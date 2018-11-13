# frozen_string_literal: true

FactoryBot.define do
  factory :plan do
    name { 'Plan 30 min' }
    base_cost { 25.00 }
    additional_cost { 15.00 }
    duration { 30 }
  end
end
