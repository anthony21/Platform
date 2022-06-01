# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :redirect_if_set, only: %i(new create)
  skip_before_action :authenticate, only: %i(new create)

  before_action :validate_invite_token, only: %i(new)

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if params[:invite_token].present?
      account = Account.find_by!(invite_token: params[:invite_token])
      @user.account = account
      @user.role = :user
    else
      @user.role = :admin
    end

    if @user.save
      sign_in(@user)
      redirect_to :root
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if Current.user.update(user_params)
      redirect_to edit_profile_path, notice: I18n.t('registrations.account_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def validate_invite_token
    return if params[:invite].blank?

    account = Account.find_by(invite_token: params[:invite])
    redirect_to new_session_path, notice: I18n.t('registrations.invalid_invite') if account.blank?

    @invite_token = params[:invite]
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :theme, :password, :password_confirmation, :current_password,
      account_attributes: %i(id name)
    )
  end
end
