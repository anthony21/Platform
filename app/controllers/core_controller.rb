# frozen_string_literal: true

class CoreController < ApplicationController
  include CoreRedirectable

  def redirect
    @to = core_url(params[:to])
  end

  private

  def core_url(path)
    "#{core_base_url}#{path}"
  end

  def core_base_url
    ENV.fetch('CORE_URL', 'http://localhost:8080')
  end
end
