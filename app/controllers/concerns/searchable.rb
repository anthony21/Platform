# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  included do
    before_action :set_search, only: %i(index)
    before_action :set_user_filter, only: %i(index)
  end

  def set_search
    @search = params[:search]
  end

  def set_user_filter
    @user_filter = params[:user_filter] || session[user_filter_session_key] || default_user_filter
    session[user_filter_session_key] = @user_filter
  end

  def default_user_filter
    'all'
  end

  def user_filter_session_key
    "#{controller_name}_user_filter"
  end
end
