FactoryBot.define do
  factory :venue do
    name      { Faker::FunnyName.name }
    capacity  { rand(250..1000) }
  end
end
