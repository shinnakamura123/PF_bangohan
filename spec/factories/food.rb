FactoryBot.define do
  factory :food do
    id { Faker::Number.digit }
    food_name { Faker::Name.name }
    unit { Faker::Lorem.characters(number:5) }
  end
end