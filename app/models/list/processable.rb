# frozen_string_literal: true

module List::Processable
  extend ActiveSupport::Concern

  included do
    after_create :process_later
  end

  def breakdowns
    []
  end

  def process
    "List::Processors::#{list_type.capitalize}ListProcessor".constantize.new(self).process
  end

  def process_later
    List::ProcessJob.perform_later(id)
  end
end
