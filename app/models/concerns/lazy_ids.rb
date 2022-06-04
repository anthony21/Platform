# frozen_string_literal: true

# This is a workaround for the Rails issue described in https://github.com/rails/rails/issues/17368.
module LazyIds
  extend ActiveSupport::Concern

  included do
    after_save :persist_lazy_ids
  end

  def persist_lazy_ids
    return unless @_lazy_ids

    @_lazy_ids.each do |association, ids|
      public_send(:"eager_#{association.to_s.singularize}_ids=", ids)
    end

    @_lazy_ids = {}
  end

  module ClassMethods
    def lazy_ids(association)
      alias_method :"eager_#{association.to_s.singularize}_ids=",
                   :"#{association.to_s.singularize}_ids="

      define_method "#{association.to_s.singularize}_ids=" do |ids|
        @_lazy_ids ||= {}
        @_lazy_ids[association] = ids.reject(&:blank?)
      end

      define_method association do
        return super() unless @_lazy_ids.try(:[], association)

        self.class.reflect_on_association(association).klass.find(@_lazy_ids[association])
      end
    end
  end
end
