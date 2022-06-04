# frozen_string_literal: true

module Phoneable
  extend ActiveSupport::Concern

  included do
    before_validation :set_phone_type
  end

  def phones?
    phones != 'none'
  end

  def all_phones?
    phones == 'all'
  end

  def phones_where_available?
    phones == 'where_available'
  end

  private

  def set_phone_type
    self.phone_type ||= {
      'landline_wireless' => 'landline_priority',
      'phones' => 'phone'
    }[data_source&.phones]
  end
end
