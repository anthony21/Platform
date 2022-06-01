# frozen_string_literal: true

class Address
  include NestedModel

  root_key 'address'

  attribute :name, :string
  attribute :company, :string
  attribute :address, :string
  attribute :address2, :string
  attribute :city, :string
  attribute :state, :string
  attribute :zip, :string
  attribute :country, :string
  attribute :phone, :string
  attribute :email, :string
end
