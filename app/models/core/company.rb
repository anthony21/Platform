# frozen_string_literal: true

class Core::Company < Core::Record
  self.table_name = 'companies'

  has_many :partners, class_name: 'Core::Partner'
  has_many :vendors, class_name: 'Core::Vendor'
end
