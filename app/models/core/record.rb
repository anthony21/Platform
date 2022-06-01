# frozen_string_literal: true

class Core::Record < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :core, reading: :core }
end
