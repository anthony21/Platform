# frozen_string_literal: true

FactoryBot.define do
  factory :core_vendor, class: 'Core::Vendor' do
    is_in_house { true }
    contact_name { 'Michael Duvenary' }
    contact_email { 'mduvenary@yahoo.com' }
    created { Time.now.as_core_time }
    name { 'URBAN OUTLETS' }
    match_key { 'urbanoutlets' }
    address { '819 N adams street' }
    address2 { nil }
    city { 'Glendale' }
    state { 'CA' }
    zip { '91206' }
    phone { '(323) 441-5513' }
    toll_free_number { nil }
    cust_service_number { nil }
    fax { nil }

    association :company, factory: :core_company
  end
end
