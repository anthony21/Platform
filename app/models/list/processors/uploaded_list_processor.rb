# frozen_string_literal: true

require 'csv'

class List::Processors::UploadedListProcessor
  include Loggable
  include Statsdable

  def initialize(list)
    @list = list
  end

  def process
    update_status!('processing')

    update_record_count
    process_upload

    update_status!('ready')
    notify_user
    statsd.increment('list.process.uploaded.success')
  rescue StandardError
    update_status!('failed')
    statsd.increment('list.process.uploaded.failure')
    raise
  end

  time :process, 'list.process.upload'

  private

  def update_status!(status)
    @list.update!(status:)
  end

  def update_record_count
    @list.update!(record_count: List::LineCounter.count(@list))
  end

  def process_upload
    @skipped_count = 0

    @list.file.open do |file|
      Snowflake::Uploader.new(table_name, columns).upload do |uploader|
        CSV.foreach(file.path, liberal_parsing: true, headers: true).each_with_index do |row, index|
          parsed_row = parse_row(row, index)
          next if parsed_row.blank?

          uploader << parsed_row
        end
      end
    end

    log "Skipped #{@skipped_count} rows for list #{@list.id}"
  end

  def parse_row(row, index)
    parsed_row = []

    column_mappings.map do |_, column_index|
      parsed_row << format_value(row[column_index])
    end

    if parsed_row.all?(&:blank?)
      @skipped_count += 1
      return
    end

    parsed_row.unshift(index)
    parsed_row.unshift(@list.id)
  end

  def format_value(value)
    value&.upcase&.strip&.gsub(/[\r\n]/, '')
  end

  def columns
    ['list_id', 'line_number', column_mappings.keys].flatten.join(', ').upcase
  end

  def table_name
    "FIVETRAN_DATABASE.S3.#{Rails.env.upcase}_LISTS"
  end

  def column_mappings
    @column_mappings ||= @list.column_mappings.map do |field, index|
      [field, index.to_i] if index.present?
    end.compact.to_h
  end

  def notify_user
    ListMailer.with(list: @list).uploaded_list_ready.deliver_later
  end
end
