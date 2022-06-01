# frozen_string_literal: true

FactoryBot.define do
  factory :core_company, class: 'Core::Company' do
    name { 'URBAN OUTLETS' }
    match_key { 'urbanoutlets' }
    address { '819 n adams' }
    address2 { nil }
    city { 'Glendale' }
    state { 'CA' }
    country { 'US' }
    zip { '91320' }
    phone { '(805) 267-1575' }
    toll_free_number { nil }
    cust_service_number { nil }
    fax { nil }
    created { Time.now.as_core_time }
    division_of { nil }
  end
end
