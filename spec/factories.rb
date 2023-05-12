FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    password { Faker::Internet.password(min_length: 8) }
  end
end
