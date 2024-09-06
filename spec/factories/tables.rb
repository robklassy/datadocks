FactoryBot.define do
  factory :table do
    identifier { "MyString" }
    number_of_seats { 1 }
    active { false }
    restaurant_id { nil }
  end
end
