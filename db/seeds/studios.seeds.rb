
puts "Creating Studios"
seed_data = [
    {name: "Alien Beans Studios", description: "", engineer_name: Faker::FunnyName.name, cost: 100},
    {name: "Dark Horse Recording Studio", description: "", engineer_name: Faker::FunnyName.name, cost: 500},
    {name: "Studio 19", description: "", engineer_name: Faker::FunnyName.name, cost: 5_000},
    {name: "Pet Sounds Studio", description: "", engineer_name: Faker::FunnyName.name, cost: 10_000},
]

seed_data.each do |seed|
  studio = Studio.where(name: seed[:name]).first_or_initialize
  studio.update(seed)
  puts "  #{studio.name} / Cost: #{studio.cost}".blue
end
puts

