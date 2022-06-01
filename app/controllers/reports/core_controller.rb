# frozen_string_literal: true

class Reports::CoreController < ApplicationController
  def index
    redirect_to action: :count
  end

  def count
    respond_with_report Core::Reports::CountReport
  end

  def flagged_po
    respond_with_report Core::Reports::FlaggedPoReport
  end

  def order
    respond_with_report Core::Reports::OrderReport
  end

  def purchase_order
    respond_with_report Core::Reports::PurchaseOrderReport
  end

  def processor
    respond_with_report Core::Reports::ProcessorReport, user_id: params[:user_id]
  end

  def trend
    respond_with_report Core::Reports::TrendReport
  end

  def timings
    respond_with_report Core::Reports::TimingsReport
  end

  def counts_by_database
    respond_with_report Core::Reports::CountsByDatabaseReport
  end

  def counts_by_vendor
    respond_with_report Core::Reports::CountsByVendorReport
  end

  def purchase_orders_by_database
    respond_with_report Core::Reports::PurchaseOrdersByDatabaseReport
  end

  def purchase_orders_by_vendor
    respond_with_report Core::Reports::PurchaseOrdersByVendorReport
  end

  private

  def respond_with_report(report, **options)
    @report = report.new(start_at: params[:start_at], end_at: params[:end_at], **options)

    respond_to do |format|
      format.json { render json: @report.run }
      format.html
    end
  end
end
