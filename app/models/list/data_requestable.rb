# frozen_string_literal: true

module List::DataRequestable
  extend ActiveSupport::Concern

  def data_request
    request = Data::Request.new(self).build
    request[:breakdowns] = []
    request[:output_fields] = output_fields.map(&:key)
    request[:sample] = record_count
    request
  end

  def output_fields
    @output_fields ||= (
      data_source.output_fields +
      filter_fields +
      phone_fields +
      email_fields
    ).uniq(&:key)
  end

  private

  def phone_fields
    return [] unless phones?
    return [data_source.fields[phone_type]] unless phone_type.include?('priority')

    [
      data_source.fields["#{phone_type}#{'_dnc' if dnc}"],
      data_source.fields['phone_type']
    ]
  end

  def email_fields
    emails? ? [data_source.fields['email']] : []
  end

  def filter_fields
    filters.fields.map(&:output_fields).flatten
  end
end
