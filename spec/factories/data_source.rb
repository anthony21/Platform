# frozen_string_literal: true

FactoryBot.define do
  factory :data_source do
    name { 'Consumer' }
    active { true }
    snowflake_table_name { 'FIVETRAN_DATABASE.S3.GP_21_1' }

    factory :business_email_data_source do
      name { 'Business Email' }
      snowflake_table_name { 'FIVETRAN_DATABASE.S3.GPB2B_2021_1B_EM_DND' }
    end

    factory :auto_data_source do
      name { 'Auto' }
      snowflake_table_name { 'FIVETRAN_DATABASE.S3.GPAUTO2021_1D_DND' }
    end
  end
end
