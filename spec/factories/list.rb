# frozen_string_literal: true

FactoryBot.define do
  factory :list do
    name { Faker::FunnyName.name }
    record_count { 1500 }
    status { 'submitted' }
    list_type { 'audience' }
    filters { audience&.filters }
    geography { audience&.geography }
    omissions { audience&.omissions }
    select_type { audience&.select_type }
    phones { audience&.phones }
    phone_type { audience&.phone_type }
    dnc { audience&.dnc }
    emails { audience&.emails }
    suppression_lists { audience&.suppression_lists || [] }

    audience
    user { audience&.user }
    data_source { audience&.data_source }

    factory :uploaded_list do
      name { Faker::File.file_name(ext: 'csv') }
      record_count { nil }
      list_type { 'uploaded' }
      column_mappings do
        {
          'first_name' => '0',
          'last_name' => '1',
          'address' => '2',
          'address_2' => '3',
          'zip' => '5',
          'phone' => '6',
          'email' => '7'
        }
      end

      user
      audience { nil }
      data_source { nil }

      after(:build) do |list|
        list.file.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'my-list.csv')),
          filename: list.name,
          content_type: 'text/csv'
        )
      end
    end

    factory :core_list do
      name { core_shipment.order.id.to_s }
      record_count { nil }
      status { 'ready' }
      list_type { 'core' }
      column_mappings do
        {
          'last_name' => '',
          'address' => '',
          'address_2' => '',
          'zip' => '',
          'phone' => '',
          'email' => ''
        }
      end

      user
      audience { nil }
      data_source { nil }
      association :core_shipment, factory: :core_shipment
    end
  end
end
