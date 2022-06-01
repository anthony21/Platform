# frozen_string_literal: true

class Core::Vendor < Core::Record
  self.table_name = 'vendors'

  belongs_to :company, class_name: 'Core::Company'

  def self.urban_outlets
    find_by!(match_key: 'urbanoutlets')
  end
end
