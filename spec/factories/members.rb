FactoryBot.define do
  factory :member do
    name      { Faker::FunnyName.name }
    gender    { ['male','female'].sample }
    birthdate { Faker::Date.birthday(18, 40) }
    trait_ego         { rand(0..100) }
    trait_looks       { rand(0..100) }
    trait_creativity  { Sample.weighted(1..100) }
    trait_fatigue 0
    primary_skill     { Skill.all.sample }
    skill_primary_level { Sample.weighted(1..100) }
  end
end