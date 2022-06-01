# frozen_string_literal: true

require 'csv'
require 'zip'

class List::Processors::AppendListProcessor
  include Loggable
  include Statsdable

  def initialize(list)
    @list = list
  end

  def process
    update_status!('processing')

    csv_tempfile = Tempfile.new
    csv = CSV.open(csv_tempfile, 'w')
    add_headers(csv)

    fetch_appended_data

    @list.original_list.file.open do |file|
      CSV.foreach(file.path, liberal_parsing: true, headers: true).each_with_index do |row, index|
        process_row(row, index, csv)
      end
    end

    csv.close
    zip_tempfile = zip_csv(csv_tempfile)
    attach_zip(zip_tempfile)

    update_record_count!
    update_status!('ready')
    statsd.increment('list.process.append.success')
    notify_user
  rescue StandardError
    update_status!('failed')
    statsd.increment('list.process.append.failure')
    raise
  ensure
    csv.try(:close)
    csv_tempfile.try(:unlink)
    zip_tempfile.try(:unlink)
  end

  time :process, 'list.process.append'

  private

  def update_status!(status)
    @list.update!(status:)
  end

  def add_headers(csv)
    csv << [original_list_headers, appended_headers].flatten
  end

  def original_list_headers
    @list.original_list.file.open(&:readline).gsub(/["\r\n]/, '').split(',')
  end

  def appended_headers
    @list.append_output_fields.map(&:display_name).map(&:upcase)
  end

  def fetch_appended_data
    @appended_data = {}

    Data.new(@list.append_data_request).results.each do |record|
      @appended_data[record.delete(:line_number).to_i] = record
    end

    @record_count = 0
  end

  def lists_table_name
    "FIVETRAN_DATABASE.S3.#{Rails.env.upcase}_LISTS"
  end

  def process_row(row, index, csv)
    appended_row = @appended_data[index]
    formatted_row = row.to_s.gsub(/\n/, '')

    if appended_row.blank?
      csv << formatted_row.split(',')
      return
    end

    @record_count += 1

    csv << [
      formatted_row.split(',', -1),
      @list.append_output_fields.map do |field|
        formatted_value(field, appended_row)
      end
    ].flatten
  end

  def formatted_value(field, record)
    value = record[field.key.to_sym]
    return if value.blank?

    field.value_label(value).to_s.upcase
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

  def update_record_count!
    @list.update!(record_count: @record_count)
  end

  def notify_user
    ListMailer.with(list: @list).append_list_ready.deliver_later
  end
end
