# frozen_string_literal: true

require 'csv'
require 'zip'

class List::Processors::CoreListProcessor
  include Loggable
  include Statsdable

  def initialize(list)
    @list = list
  end

  def process
    Zip::File.open(file_path) do |zip_file|
      zip_file.each do |entry|
        if csv?(entry.name)
          csv = CSV.parse(entry.get_input_stream.read)
          update_column_mappings!(csv.first)

          Snowflake::Uploader.new(table_name, columns).upload do |uploader|
            csv[1..].each do |row|
              parsed_row = parse_row(row)
              next if parsed_row.blank?

              uploader << parsed_row
            end
          end
        else
          log 'Zipped file is not a csv'
        end
      end
    end

    statsd.increment('list.process.core.success')
  rescue StandardError
    statsd.increment('list.process.core.failure')
    raise
  end

  time :process, 'list.process.core'

  private

  def file_path
    ActiveStorage::Blob.service.path_for(@list.file.key)
  end

  def csv?(file_name)
    file_name.downcase.end_with?('.csv')
  end

  def update_column_mappings!(headers)
    @list.update!(
      column_mappings: {
        'first_name' => find_mapping_index(headers, 'FIRST'),
        'last_name' => find_mapping_index(headers, 'LAST'),
        'address' => find_mapping_index(headers, 'ADDRESS'),
        'address_2' => find_mapping_index(headers, 'ADDRESS2'),
        'zip' => find_mapping_index(headers, 'ZIP'),
        'phone' => find_mapping_index(headers, 'PHONE'),
        'email' => find_mapping_index(headers, 'EMAIL')
      }
    )
  end

  def find_mapping_index(headers, column_name)
    headers.find_index { |header| header.upcase.include?(column_name) } || ''
  end

  def table_name
    "FIVETRAN_DATABASE.S3.#{Rails.env.upcase}_LISTS"
  end

  def columns
    %w(LIST_ID FIRST_NAME LAST_NAME ADDRESS ADDRESS_2 ZIP PHONE EMAIL).join(', ')
  end

  def parse_row(row)
    parsed_row = []

    @list.column_mappings.each_value do |value|
      parsed_row << (value.present? ? format_value(row[value]) : nil)
    end

    return if parsed_row.all?(&:blank?)

    parsed_row.unshift(@list.id)
  end

  def format_value(value)
    value&.upcase&.strip&.gsub(/[\r\n]/, '')
  end
end
