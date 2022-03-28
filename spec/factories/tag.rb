FactoryBot.define do
  factory :tag do
    id { Faker::Number.digit }
    tag_name { Faker::Name.name }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end