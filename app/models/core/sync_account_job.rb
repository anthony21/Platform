# frozen_string_literal: true

class Core::SyncAccountJob < ApplicationJob
  queue_as :default

  def perform(id)
    Core::Account.find(id).sync!
  end
end
