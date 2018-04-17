if Manager.count < 10
  puts "Managers"
  10.times do
    manager = Manager.create!(name: Faker::Name.name, email: Faker::Internet.email,
      password: 'password', password_confirmation: 'password')

    if rand(100) > 50
      rand(1..6).times do
        if rand() > 0.5
          Manager::EarnMoney.(manager: manager, amount: rand(1..10) * 100)
        else
          Manager::SpendMoney.(manager: manager, amount: rand(1..10) * 100)
        end
      end
    end
    puts "  #{manager.name} / #{manager.balance}".blue
  end
  puts
end

