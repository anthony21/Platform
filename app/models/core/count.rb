# frozen_string_literal: true

class Core::Count < Core::Record
  enum :status, {
    new_count: 0,
    submitted: 10,
    resubmitted: 11,
    processing: 20,
    completed: 100,
    ordered: 200,
    dead: 1000
  }, default: :new_count

  self.table_name = 'counts'

  belongs_to :user, class_name: 'Core::User'
  belongs_to :processor, class_name: 'Core::User'

  serialize :selects, JSON

  scope :completed_at, -> (completed_at) { completed.where(completed: completed_at) }
end
