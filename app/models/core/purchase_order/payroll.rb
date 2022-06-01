# frozen_string_literal: true

module Core::PurchaseOrder::Payroll
  extend ActiveSupport::Concern

  included do
    after_save :update_payroll, if: :products_previously_changed?
  end

  private

  def update_payroll
    reload_payroll_record.present? ? update_payroll_record : create_payroll_record
  end

  def update_payroll_record
    payroll_item = payroll_record.payroll_item

    if payroll_item.present?
      payroll_item.update!(po_amount: [payroll_item.po_amount - payroll_record.po_amount, 0].max)
    end

    if product_amount <= 0
      payroll_record.destroy!
    else
      payroll_item&.update!(po_amount: payroll_item.po_amount + product_amount)
      payroll_record.update!(po_amount: product_amount)
    end
  end

  def create_payroll_record
    return if product_amount <= 0

    Core::PayrollRecord.create!(
      purchase_order: self,
      order:,
      rep: order.rep,
      amount_paid: 0,
      vendor_cost: 0,
      date: created,
      po_amount: product_amount
    )
  end
end
