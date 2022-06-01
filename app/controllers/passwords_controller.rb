# frozen_string_literal: true

class PasswordsController < ApplicationController
  skip_before_action :redirect_if_set
  skip_before_action :authenticate

  before_action :set_user, only: %i(edit update set confirm)

  def new; end

  def create
    user = User.find_by(email: params[:email])
    PasswordMailer.with(user:).reset_password.deliver_later if user&.generate_reset_password_token!

    redirect_to new_session_path, notice: I18n.t('passwords.email_notice')
  end

  def edit; end

  def update
    if @user.update(reset_password_params)
      redirect_to new_session_path, notice: I18n.t('passwords.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def set; end

  def confirm
    if @user.update(reset_password_params)
      sign_in(@user)
      redirect_to :root, notice: I18n.t('passwords.set')
    else
      render :set, status: :unprocessable_entity
    end
  end

  private

  def set_user
    token = params[:token] || reset_password_params[:reset_password_token]
    @user = User.find_by(reset_password_token: token)
    redirect_to new_session_path, alert: I18n.t('passwords.invalid_link') if @user.blank?
  end

  def reset_password_params
    params.require(:user).permit(:password, :password_confirmation, :reset_password_token)
  end
end
