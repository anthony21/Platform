# frozen_string_literal: true

class List::ProcessJob < ApplicationJob
  queue_as :default

  def perform(list_id)
    List.find(list_id).process
  end
end
