FactoryBot.define do
  factory :restaurant_hour do
    restaurant { nil }
    day_of_week { "MyString" }
    open_at { "2024-09-05 13:38:43" }
    close_at { "2024-09-05 13:38:43" }
  end
end
