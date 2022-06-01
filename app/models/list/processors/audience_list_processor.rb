# frozen_string_literal: true

require 'csv'
require 'zip'

class List::Processors::AudienceListProcessor
  include Loggable
  include Statsdable

  def initialize(list)
    @list = list
  end

  def process
    update_status!('processing')
    update_column_mappings!

    csv_tempfile = Tempfile.new
    csv = CSV.open(csv_tempfile, 'w')
    add_headers(csv)

    Snowflake::Uploader.new(lists_table_name, columns).upload do |uploader|
      Data.new(@list.data_request).results.each do |record|
        process_record(uploader, record, csv)
      end
    end

    csv.close
    zip_tempfile = zip_csv(csv_tempfile)
    attach_zip(zip_tempfile)

    update_status!('ready')
    statsd.increment('list.process.audience.success')
    notify_user
  rescue StandardError
    update_status!('failed')
    statsd.increment('list.process.audience.failure')
    raise
  ensure
    csv.try(:close)
    csv_tempfile.try(:unlink)
    zip_tempfile.try(:unlink)
  end

  time :process, 'list.process.audience'

  private

  def update_status!(status)
    @list.update!(status:)
  end

  def update_column_mappings!
    @list.update!(column_mappings: {
                    'first_name' => field_index('first'),
                    'last_name' => field_index('last'),
                    'address' => field_index('address1'),
                    'address_2' => field_index('address2'),
                    'zip' => field_index('zip'),
                    'phone' => field_index(phone_field_key),
                    'email' => field_index('email')
                  })
  end

  def field_index(key)
    @list.output_fields.index { |field| field.key == key }&.to_s
  end

  def add_headers(csv)
    csv << @list.output_fields.map(&:display_name).map(&:upcase)
  end

  def columns
    %w(LIST_ID FIRST_NAME LAST_NAME ADDRESS ADDRESS_2 ZIP PHONE EMAIL).join(', ')
  end

  def lists_table_name
    "FIVETRAN_DATABASE.S3.#{Rails.env.upcase}_LISTS"
  end

  def process_record(uploader, record, csv)
    csv << @list.output_fields.map do |field|
      formatted_value(field, record)
    end

    suppression_values = suppression_fields.map do |field_key|
      field_key = phone_field_key if field_key == 'phone'
      field = @list.data_source.fields[field_key]
      formatted_value(field, record)
    rescue DataSource::Fields::FieldNotFoundException
    end
    uploader << suppression_values.unshift(@list.id)
  end

  def formatted_value(field, record)
    value = record[field.key.to_sym]
    return if value.blank?

    field.value_label(value).to_s.upcase
  end

  def suppression_fields
    @suppression_fields ||= %w(first last address1 address2 zip phone email)
  end

  def phone_field_key
    phone_field = @list.output_fields.find { |field| phone_field_keys.include?(field.key) }
    phone_field&.key
  end

  def phone_field_keys
    %w(phone landline landline_dnc wireless wireless_dnc landline_priority_dnc landline_priority
       wireless_priority_dnc wireless_priority)
  end

  def zip_csv(csv_tempfile)
    zip_tempfile = Tempfile.new

    Zip::File.open(zip_tempfile, Zip::File::CREATE) do |zipfile|
      zipfile.add("#{file_name}.csv", csv_tempfile.path)
    end

    zip_tempfile
  end

  def file_name
    @list.name.parameterize
  end

  def attach_zip(zip_tempfile)
    @list.file.attach(
      io: File.open(zip_tempfile),
      filename: "#{file_name}.zip"
    )
  end

  def notify_user
    ListMailer.with(list: @list).audience_list_ready.deliver_later
  end
end
