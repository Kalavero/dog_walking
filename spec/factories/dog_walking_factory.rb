FactoryBot.define do
  factory :dog_walking do
    appointment_date { Time.now }
    price { 25.00 }
    duration { 30 }
    start_time { Time.now }
    end_time { Time.now + 30.minutes }
    latitude { 0.0 }
    longitude { 0.0 }
  end
end
