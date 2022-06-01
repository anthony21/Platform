# frozen_string_literal: true

class Core::InvoiceStatusLog < Core::Record
  self.table_name = 'invoice_status_log'

  enum :status, Core::Invoice.statuses

  belongs_to :user, class_name: 'Core::User'
  belongs_to :invoice, class_name: 'Core::Invoice'

  validates :date, presence: true
  validates :status, presence: true
  validates :notes, presence: true
end
