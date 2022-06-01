# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  helper :component

  default from: 'help@urbanoutlets.com'
  layout 'mailer'
end
