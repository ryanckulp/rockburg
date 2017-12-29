# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

200.times {
Member.create!([
  {
    #name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    name: Faker::FunnyName.name,
    gender: ['M','F'].sample,
    birthdate: rand(15..75).years.ago,
    trait_ego: rand(0..100),
    trait_looks: rand(0..100),
    trait_creativity: (1..100).map { |i| (101 - i).times.map { i } }.flatten.sample,
    trait_fatigue: 0,
    skill_primary: Skill.find(Skill.ids.shuffle.first),
    skill_primary_level: (1..100).map { |i| (101 - i).times.map { i } }.flatten.sample
  }
])
}

# Skills
Skill.delete_all
Skill.create!([
  { name: "Acoustic Guitar" },
  { name: "Banjo" },
  { name: "Bass Guitar" },
  { name: "Dance" },
  { name: "DJ" },
  { name: "Drummer" },
  { name: "Horns" },
  { name: "Keyboards" },
  { name: "Lead Guitar" },
  { name: "Percussion" },
  { name: "Piano" },
  { name: "Rapping" },
  { name: "Rhythm Guitar" },
  { name: "Strings" },
  { name: "Vocals" },
  { name: "Wind" }
])

# Genres
Genre.delete_all

genre = Genre.create(name: "Dance", style: "Ambient", min_members: 1, max_members: 2)
Skill.find_by_name('Keyboards').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Dance", style: "Disco", min_members: 4, max_members: 6)
Skill.find_by_name('Keyboards').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Drummer').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Dance').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Vocals').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Dance", style: "Drum & Bass", min_members: 1, max_members: 3)
Skill.find_by_name('DJ').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Dance", style: "Euro Dance", min_members: 3, max_members: 4)
Skill.find_by_name('Keyboards').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Dance').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Vocals').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Dance", style: "Garage", min_members: 2, max_members: 3)
Skill.find_by_name('Keyboards').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Rapping').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Dance", style: "House", min_members: 2, max_members: 4)
Skill.find_by_name('Keyboards').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Vocals').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Dance", style: "Techno", min_members: 1, max_members: 3)
Skill.find_by_name('Keyboards').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Dance", style: "Trance", min_members: 1, max_members: 3)
Skill.find_by_name('Keyboards').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Folk", style: "Bluegrass", min_members: 4, max_members: 5)
Skill.find_by_name('Acoustic Guitar').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Banjo').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Drummer').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Vocals').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Folk", style: "Country & Western", min_members: 4, max_members: 5)
Skill.find_by_name('Acoustic Guitar').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Banjo').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Drummer').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Vocals').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Folk", style: "Folk Rock", min_members: 5, max_members: 6)
Skill.find_by_name('Acoustic Guitar').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Bass Guitar').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Drummer').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Vocals').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Wind').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Folk", style: "Irish Folk", min_members: 5, max_members: 6)
Skill.find_by_name('Acoustic Guitar').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Percussion').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Strings').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Dance').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Wind').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Folk", style: "Traditional Folk", min_members: 3, max_members: 4)
Skill.find_by_name('Acoustic Guitar').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Percussion').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Strings').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Folk", style: "World Music", min_members: 3, max_members: 4)
Skill.find_by_name('Percussion').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Vocals').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Wind').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Orchestral", style: "Big Band", min_members: 5, max_members: 6)
Skill.find_by_name('Drummer').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Piano').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Horns').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Dance').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Wind').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Orchestral", style: "Classical", min_members: 6, max_members: 7)
Skill.find_by_name('Acoustic Guitar').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Percussion').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Piano').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Strings').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Dance').genre_skills.create(genre_id: genre.id)
Skill.find_by_name('Wind').genre_skills.create(genre_id: genre.id)

genre = Genre.create(name: "Orchestral", style: "Concert Pianist", min_members: 1, max_members: 2)
Skill.find_by_name('Piano').genre_skills.create(genre_id: genre.id)
