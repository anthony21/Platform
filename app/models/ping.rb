# frozen_string_literal: true

class Ping
  FIELDS = %i(
    first
    last
    address1
    address2
    city
    state
    zip
    zip4
  ).freeze

  def initialize(account, params)
    @account = account
    @params = params
  end

  def results
    @results = Data.new(data_request).results
    log
    @results
  end

  private

  def data_request
    {
      data_source: data_source.id,
      filters:,
      output_fields: FIELDS.map(&:to_s)
    }
  end

  def filters
    phone = @params[:phone]
    return if phone.blank?

    phone = phone.gsub(/[^\d]/, '')

  end

  def log
    LogApiRequestJob.perform_later(@account.id, 'ping', @params, @results.size, Time.now)
  end

end
