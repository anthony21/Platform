# frozen_string_literal: true

module List::Deletable
  extend ActiveSupport::Concern

  included do
    after_commit :delete_snowflake_list_later, on: :destroy
  end

  class_methods do
    def delete_snowflake_list(list_id)
      snowflake_client ||= Snowflake::Client.new

      snowflake_client.execute(
        "DELETE FROM FIVETRAN_DATABASE.S3.#{Rails.env.upcase}_LISTS
        WHERE LIST_ID = #{list_id}"
      )
    end
  end

  def delete_snowflake_list_later
    List::DeleteSnowflakeListJob.perform_later(id)
  end
end
