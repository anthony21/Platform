# frozen_string_literal: true

class Core::CountStatusLog < Core::Record
  self.table_name = 'count_status_log'

  enum :status, Core::Count.statuses

  belongs_to :user, class_name: 'Core::User'
end
