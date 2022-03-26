FactoryBot.define do
  factory :user do
    id { Faker::Number.digit }
    email { Faker::Internet.email}
    name { Faker::Name.name }
    password { Faker::Number.number(digits: 10) }
    introduction { Faker::Lorem.characters(number:10) }
    is_deleted { Faker::Boolean.boolean(true_ratio: 0.2) }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end