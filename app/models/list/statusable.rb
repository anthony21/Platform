# frozen_string_literal: true

module List::Statusable
  extend ActiveSupport::Concern

  STATUS = {
    submitted: 'submitted',
    processing: 'processing',
    ready: 'ready',
    failed: 'failed'
  }.freeze

  included do
    validates :status, inclusion: { in: STATUS.values }

    before_validation :set_status

    scope :ready, -> { where(status: 'ready') }
  end

  def ready!
    update!(status: 'ready')
  end

  def ready?
    status == 'ready'
  end

  private

  def set_status
    self.status ||= 'submitted'
  end
end
