FactoryBot.define do
  factory :reservation do
    customer { nil }
    table { nil }
    restaurant { nil }
    start_at { "2024-09-05 15:40:48" }
    end_at { "2024-09-05 15:40:48" }
    number_of_guests { 1 }
    state { "MyString" }
  end
end
