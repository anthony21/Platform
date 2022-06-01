# frozen_string_literal: true

class AccountsController < ApplicationController
  include Searchable
  include Pageable

  feature :account_management, only: :index

  before_action :set_account, except: :index
  before_action :redirect_unauthorized, unless: :authorized?, except: :index

  def index
    @pagy, @accounts = pagy(Account.search(@search))
  end

  def show; end

  def edit; end

  def update
    if @account.update(account_params)
      redirect_to @account, notice: I18n.t('accounts.updated', name: @account.name)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def history
    @pagy, @history = pagy(@account.audits.reorder(created_at: :desc, id: :desc))
  end

  def activity
    @pagy, @history = pagy(Account.activity(@account))
  end

  def billing
    @pagy, @invoices = pagy(@account.invoices)
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def authorized?
    return true if Feature.enabled? :account_management
    return false if Current.account != @account

    action_name == 'activity' || Feature.enabled?(:account_admin)
  end

  def account_params
    params.require(:account).permit(:name)
  end
end
