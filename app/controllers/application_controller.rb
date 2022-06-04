# frozen_string_literal: true

class ApplicationController < ActionController::Base
    include Securable
    include Featureable
    include Statsdable
    include SentryContext
    include SystemNotices
    include CurrentRequest
  
    def current_user
      Current.user
    end
  end
  