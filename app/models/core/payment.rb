# frozen_string_literal: true

class Core::Payment < Core::Record
  self.table_name = 'payment'

  belongs_to :invoice, class_name: 'Core::Invoice'
  belongs_to :submitted_by, class_name: 'Core::User', foreign_key: :submitted_by
end
