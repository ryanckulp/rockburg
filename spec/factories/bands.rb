FactoryBot.define do
  factory :band do
    name      { Generators::BandName.call.result }
    manager
    genre     { Genre.all.sample }
    fans      { rand(0..500) }
    buzz      { rand(0..500) }
  end
end