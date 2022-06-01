# frozen_string_literal: true

class List::MatchType
  def initialize(column_mappings)
    @column_mappings = column_mappings
  end

  def available_match_types
    return @available_match_types if @available_match_types

    @available_match_types = []

    %i(address household individual phone email).each do |match_type|
      @available_match_types << match_type if __send__("#{match_type}_mapped?")
    end

    @available_match_types
  end

  private

  def address_mapped?
    mappings_present?(%w(address zip))
  end

  def household_mapped?
    mappings_present?(%w(last_name address zip))
  end

  def individual_mapped?
    mappings_present?(%w(first_name last_name address zip))
  end

  def email_mapped?
    mappings_present?(%w(email))
  end

  def phone_mapped?
    mappings_present?(%w(phone))
  end

  def mappings_present?(fields)
    return false if @column_mappings.blank?

    fields.all? { |f| @column_mappings[f].present? }
  end
end
