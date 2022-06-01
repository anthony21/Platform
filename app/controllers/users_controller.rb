# frozen_string_literal: true

class UsersController < ApplicationController
  include Pageable
  include Searchable
  include Scoped

  scoped :users
  feature :user_management
  feature :account_management, only: %i(history)

  before_action :set_user, only: %i(show edit update destroy history)

  def index
    @pagy, @users = pagy(users.search(@search).order(:first_name))
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to [@account, :users].compact,
                  notice: I18n.t('users.updated', name: @user.display_name)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def history
    @pagy, @history = pagy(@user.audits.reorder(created_at: :desc, id: :desc))
  end

  private

  def set_user
    @user = users.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role)
  end
end
