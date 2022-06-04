# frozen_string_literal: true

class ApiController < ApplicationController
  skip_before_action :authenticate
  skip_before_action :verify_authenticity_token
  skip_before_action :redirect_if_set
end
