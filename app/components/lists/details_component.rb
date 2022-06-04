# frozen_string_literal: true

class Lists::DetailsComponent < BaseComponent
  delegate :local_time, to: :helpers

  def initialize(list:, account: nil)
    @list = list
    @account = account
  end
end
