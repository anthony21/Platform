# frozen_string_literal: true

module Emailable
  extend ActiveSupport::Concern

  def emails?
    emails != 'none'
  end

  def all_emails?
    emails == 'all'
  end

  def emails_where_available?
    emails == 'where_available'
  end
end
