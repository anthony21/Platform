# frozen_string_literal: true

class Core::OrderMailer < ApplicationMailer
  def completed
    @order = params[:order]
    @subject = "Order #{@order.id} is complete"

    mail(to: @order.rep.email, subject: @subject)
  end
end
