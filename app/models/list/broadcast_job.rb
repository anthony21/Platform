# frozen_string_literal: true

class List::BroadcastJob < ApplicationJob
  queue_as :streams

  def perform(id)
    List.find(id).broadcast
  end
end
