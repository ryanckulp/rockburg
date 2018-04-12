puts "Creating Venues"
seed_data = [
    {name: "The Hole", description: "It's a hole. And you play in it.", capacity: 50},
    {name: "Sneaky Pete's", description: "Watch out for that Pete! He sneaky!", capacity: 250},
    {name: "Crazy 8's", description: "It's got a mechanical bull. Which is a nice touch.", capacity: 500},
    {name: "The Amphitheatre", description: "You have arrived, my friend!", capacity: 5000}
]
seed_data.each do |seed|
  venue = Venue.where(name: seed[:name]).first_or_initialize
  venue.update(seed)
  puts "  #{venue.name} / Capacity: #{venue.capacity}".blue
end
puts
