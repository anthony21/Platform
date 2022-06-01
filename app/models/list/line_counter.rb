# frozen_string_literal: true

class List::LineCounter
  include Disk
  include S3

  def self.count(list)
    new(list).count
  end

  def initialize(list)
    @list = list
  end

  def count
    s3? ? record_count_from_s3 : record_count_from_disk
  end

  private

  def s3?
    Rails.application.config.active_storage.service == :amazon
  end
end
