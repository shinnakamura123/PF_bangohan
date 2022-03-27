FactoryBot.define do
  factory :recipe do
    id { Faker::Number.digit }
    user_id { Faker::Number.digit}
    recipe_name { Faker::Name.name }
    man_count { Faker::Number.digit }
    point { Faker::Lorem.characters(number:10) }
    status { 0 }
    background { Faker::Lorem.characters(number:10) }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end