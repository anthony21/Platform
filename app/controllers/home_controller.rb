<<<<<<< HEAD
class HomeController < ApplicationController
  def index
=======
# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @queue = [
      Current.account.orders.ready_for_client.order(updated: :desc).limit(10),
      Current.account.invoices.open_for_payment.order(updated: :desc).limit(10)
    ].flatten.sort_by(&:updated).reverse[0..9]

    @history = Account.activity(Current.account).limit(10)
>>>>>>> origin/main
  end
end
