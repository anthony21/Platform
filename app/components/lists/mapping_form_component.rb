# frozen_string_literal: true

class Lists::MappingFormComponent < BaseComponent
  def initialize(name: nil, first_line: nil, list: nil)
    @name = name
    @first_line = first_line
    @list = list
  end

  def name
    @name || @list&.name
  end

  def first_line
    @first_line || @list&.first_line
  end

  def form
    @form ||= FormBuilder.new('list', @list || List.new, self, {})
  end

  def mapping_fields
    %w(first_name last_name address address_2 zip email phone)
  end

  def select_options
    @select_options ||= headers.map.with_index.to_a
  end

  def headers
    first_line.split(',')
  end

  def column_mapping(field)
    return '' if @list.nil?

    @list.column_mappings[field]
  end

  def mapping_error
    @list.try(:errors)&.find { |e| e.attribute == :column_mappings }
  end
end
