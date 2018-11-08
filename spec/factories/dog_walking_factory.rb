# frozen_string_literal: true

FactoryBot.define do
  factory :dog_walking do
    appointment_date { Time.zone.now }
    price { 25.00 }
    duration { 30 }
    start_time { Time.zone.now }
    end_time { Time.zone.now + 30.minutes }
    latitude { 0.0 }
    longitude { 0.0 }
  end
end
