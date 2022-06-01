# frozen_string_literal: true

class Core::Reports::TimingsReport
  attr_reader :start_at, :end_at

  def initialize(start_at: nil, end_at: nil)
    @start_at = start_at ? DateTime.parse(start_at) : 1.month.ago.beginning_of_day
    @end_at = end_at ? DateTime.parse(end_at).end_of_day : DateTime.now.end_of_day
  end

  def run
    purchase_orders = Core::PurchaseOrder.completed_at(start_at..end_at)
    purchase_order_minutes = if purchase_orders.blank?
                               'No data for this time period'
                             else
                               purchase_order_minutes = purchase_orders.average(
                                 'timestampdiff(minute, created, completed)'
                               ).round
                               format_duration(purchase_order_minutes * 60)
                             end

    counts = Core::Count.completed_at(start_at..end_at)
    count_minutes = if counts.blank?
                      'No data for this time period'
                    else
                      count_minutes = counts.average(
                        'timestampdiff(minute, submitted, completed)'
                      ).round
                      format_duration(count_minutes * 60)
                    end

    orders = Core::Order.joins(:status_logs).where(
      created: start_at..end_at,
      status_logs: { status: :completed }
    )
    order_minutes = if orders.blank?
                      'No data for this time period'
                    else
                      order_minutes = orders.average(
                        'timestampdiff(minute, orders.created, status_logs.date)'
                      ).round
                      format_duration(order_minutes * 60)
                    end

    [
      {
        name: 'Average time to complete PO',
        value: purchase_order_minutes
      },
      {
        name: 'Average time to complete Count',
        value: count_minutes
      },
      {
        name: 'Average time to complete Order',
        value: order_minutes
      }
    ]
  end

  private

  def format_duration(seconds)
    duration = ActiveSupport::Duration.build(seconds).parts

    parts = %i(years months days hours minutes seconds).map do |time|
      next if duration[time].blank?

      "#{duration[time]} #{time.to_s.singularize.pluralize(duration[time])}"
    end

    parts.compact.join(' ')
  end
end
