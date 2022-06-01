# frozen_string_literal: true

class AddressDisplayComponent < BaseComponent
  def initialize(address:)
    @address = address
  end

  def line_one
    [@address.address, @address.address2].compact_blank.join(', ')
  end

  def line_two
    "#{[@address.city, @address.state].compact_blank.join(', ')} #{@address.zip}"
  end
end
