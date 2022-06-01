# frozen_string_literal: true

class DataSource < ApplicationRecord
  include Activatable
  include Configurable

  has_many :lists
end
