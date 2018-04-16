FactoryBot.define do
  factory :song do
    band
    name      { Faker::FunnyName.name }
    quality   { rand(40..100) }
  end
end
