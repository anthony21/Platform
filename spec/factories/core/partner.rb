# frozen_string_literal: true

FactoryBot.define do
  factory :core_partner, class: 'Core::Partner' do
    uses_paygiant { true }
    initials { 'GP' }
    partner_slug { nil }
    rep_id { nil }
    partner_email { 'contact@gcpartners.net' }
    email_contact { false }
    active { true }
    created { Time.now.as_core_time }
    name { 'GIANT PARTNERS' }
    match_key { nil }
    address { '1461 Lawrence Drive' }
    address2 { nil }
    city { 'Thousand Oaks' }
    state { 'CA' }
    zip { '91320' }
    phone { '(805) 267-1575' }
    toll_free_number { nil }
    cust_service_number { nil }
    fax { nil }

    association :company, factory: :core_company
  end
end
