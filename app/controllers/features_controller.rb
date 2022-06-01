# frozen_string_literal: true

class FeaturesController < ApplicationController
  feature :super_admin

  before_action :set_user, except: :show

  def index; end

  def update
    @user.enable_feature(
      params[:id],
      enabled: !ActiveRecord::Type::Boolean::FALSE_VALUES.include?(params[:enabled])
    )
    redirect_to [@user, :features]
  end

  def show
    render json: { enabled: Feature.enabled?(params[:id]) }
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
