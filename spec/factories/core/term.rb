# frozen_string_literal: true

FactoryBot.define do
  factory :core_term, class: 'Core::Term' do
    active_date { 1.day.ago.as_core_time }
    inactive_date { nil }
    url { 'terms%2Ftermsandconditions.html' }
    description { 'Terms and Conditions' }
    classification { 'GP' }
    display { 'Standard Terms & Conditions' }
  end
end
