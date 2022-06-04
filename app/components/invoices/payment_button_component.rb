# frozen_string_literal: true

class Invoices::PaymentButtonComponent < BaseComponent
  def initialize(invoice:)
    @invoice = invoice
  end

  def payment_options
    @invoice.order.payment_options
  end

  def payment_url
    return pay_invoice_path(@invoice) if payment_options.include?('credit')

    '#' if payment_options.include?('check')
  end
end
