FactoryBot.define do
  factory :studio do
    name      { "#{Faker::FunnyName.name} Studios" }
    engineer_name  { Faker::FunnyName.name }
    cost      { rand(1..10) * 100 }
  end
end
