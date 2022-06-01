# frozen_string_literal: true

module S3able
  extend ActiveSupport::Concern

  def s3_client
    @s3_client ||= Aws::S3::Client.new
  end
end
