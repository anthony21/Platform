# frozen_string_literal: true

class List::VisualizeJob < ApplicationJob
  queue_as :default

  def perform(id)
    List.find(id).visualize
  end
end
