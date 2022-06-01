# frozen_string_literal: true

class List::DeleteSnowflakeListJob < ApplicationJob
  queue_as :default

  def perform(list_id)
    List.delete_snowflake_list(list_id)
  end
end
