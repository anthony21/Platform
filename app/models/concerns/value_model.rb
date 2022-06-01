# frozen_string_literal: true

module ValueModel
  extend ActiveSupport::Concern

  include SharedValueModel

  class_methods do
    def search(query)
      where("LOWER(#{value_column}) LIKE ?", "%#{query.downcase}%")
    end

    def find_values(ids)
      find(ids).pluck(value_column)
    end
  end

  def value
    public_send(self.class.value_column)
  end
end
