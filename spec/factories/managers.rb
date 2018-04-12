FactoryBot.define do
  factory :manager do
    name      { Faker::FunnyName.name }
    email     { Faker::Internet.email }
    password  "password"
    password_confirmation "password"
  end
end