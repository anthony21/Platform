# frozen_string_literal: true

module List::Broadcastable
  extend ActiveSupport::Concern

  included do
    after_commit :broadcast_later
  end

  def broadcast_later
    List::BroadcastJob.perform_later(id)
  end

  def broadcast
    broadcast_render partial: 'lists/list_stream'
  end
end
