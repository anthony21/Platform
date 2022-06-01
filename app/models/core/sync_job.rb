# frozen_string_literal: true

class Core::SyncJob < ApplicationJob
  queue_as :default

  def perform
    Core::Account.sync
  end
end
