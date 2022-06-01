# frozen_string_literal: true

class Core::Reports::PurchaseOrdersByVendorReport
  attr_reader :start_at, :end_at

  def initialize(start_at: nil, end_at: nil)
    @start_at = start_at ? DateTime.parse(start_at) : 1.month.ago.beginning_of_day
    @end_at = end_at ? DateTime.parse(end_at).end_of_day : DateTime.now.end_of_day
  end

  def run
    purchase_orders_by_vendor = Core::PurchaseOrder.joins(:vendor)
      .group("if(vendors.name in ('DigiGiant', 'Urban Outlets'), vendors.`name`, 'Vendor')")
      .group('date(completed)')
      .count

    (@start_at.to_date..@end_at.to_date).map do |date|
      {
        date: date.to_s,
        urban_outlets: purchase_orders_by_vendor.fetch(['Urbant Outlets', date], 0),
        digi_giant: purchase_orders_by_vendor.fetch(['DigiGiant', date], 0),
        vendors: purchase_orders_by_vendor.fetch(['Vendor', date], 0)
      }
    end
  end

  def series
    [
      { name: 'DigiGiant', key: 'digi_giant' },
      { name: 'Urban Outlets', key: 'urban_outlets' },
      { name: 'Vendor', key: 'vendors' }
    ]
  end
end
