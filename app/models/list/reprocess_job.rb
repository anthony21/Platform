# frozen_string_literal: true

class List::ReprocessJob < ApplicationJob
  queue_as :default

  def perform(list_id)
    List.find(list_id).reprocess
  end
end
