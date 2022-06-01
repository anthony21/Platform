class CoreRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :core }
end
