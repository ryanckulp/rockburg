puts "Creating Genres"

seed_data = [
  { name: 'Dance', style: "Ambient", min_members: 1, max_members: 2,
    skills: %w[Keyboards]
  },
  { name: 'Dance', style: "Disco", min_members: 4, max_members: 6,
    skills: %w[Keyboards Drummer Dance Vocals Horns Percussion Backup_Vocals]
  },
  { name: 'Dance', style: "Drum & Bass", min_members: 1, max_members: 3,
    skills: %w[Keyboards Drummer Dance Vocals]
  },
  { name: "Dance", style: "Euro Dance", min_members: 3, max_members: 4,
    skills: %w[Keyboards Dance Vocals Backup_Vocals]
  },
  { name: "Dance", style: "Garage", min_members: 2, max_members: 3,
    skills: %w[Keyboards Rapping]
  },
  { name: "Dance", style: "House", min_members: 2, max_members: 4,
    skills: %w[Keyboards Vocals]
  },
  { name: "Dance", style: "Techno", min_members: 1, max_members: 3,
    skills: %w[Keyboards]
  },
  { name: "Dance", style: "Trance", min_members: 1, max_members: 3,
    skills: %w[Keyboards]
  },
  { name: "Folk", style: 'Bluegrass',  min_members: 4, max_members: 5,
    skills: %w[Acoustic_Guitar Banjo Drummer Vocals]
  },
  { name: "Folk", style: "Folk Rock", min_members: 5, max_members: 6,
    skills: %w[Acoustic_Guitar Bass_Guitar Drummer Vocals Wind]
  },
  { name: "Folk", style: "Irish Folk", min_members: 5, max_members: 6,
    skills: %w[Acoustic_Guitar Percussion Strings Dance Wind]
  },
  { name: "Folk", style: "Traditional Folk", min_members: 3, max_members: 4,
    skills: %w[Acoustic_Guitar Percussion Strings]
  },
  { name: "Folk", style: "World Music", min_members: 3, max_members: 4,
    skills: %w[Percussion Vocals Wind]
  },
  { name: "Orchestral", style: "Big Band", min_members: 5, max_members: 6,
    skills: %w[Drummer Piano Horns Dance Wind]
  },
  { name: "Orchestral", style: "Classical", min_members: 6, max_members: 7,
    skills: %w[Acoustic_Guitar Percussion Piano Strings Dance Wind]
  },
  { name: "Orchestral", style: "Concert Pianist", min_members: 1, max_members: 2,
    skills: %w[Piano]
  },
  { name: "Pop", style: "Brit Pop", min_members: 3, max_members: 5,
    skills: %w[Acoustic_Guitar Electric_Guitar Bass_Guitar Drummer Vocals]
  },
  { name: "Pop", style: "Euro Pop", min_members: 3, max_members: 5,
    skills: %w[Keyboards Bass_Guitar Dance Vocals]
  },
  { name: "Pop", style: "Boy Band", min_members: 3, max_members: 5,
    skills: %w[Drummer Dance Vocals]
  },
  { name: "Pop", style: "Girl Band", min_members: 3, max_members: 5,
    skills: %w[Drummer Dance Vocals]
  },
  { name: "Pop", style: "Latin", min_members: 3, max_members: 5,
    skills: %w[Drummer Dance Vocals Percussion]
  },
  { name: "Rock", style: "Gothic", min_members: 4, max_members: 6,
    skills: %w[Bass_Guitar Drummer Keyboards Lead_Guitar Vocals]
  },
  { name: "Rock", style: "Indie", min_members: 4, max_members: 6,
    skills: %w[Bass_Guitar Drummer Keyboards Acoustic_Guitar Vocals]
  },
  { name: "Rock", style: "Metal", min_members: 4, max_members: 6,
    skills: %w[Bass_Guitar Drummer Lead_Guitar Rhythm_Guitar Vocals]
  },
  { name: "Rock", style: "Punk", min_members: 3, max_members: 5,
    skills: %w[Bass_Guitar Drummer Lead_Guitar Vocals]
  },
  { name: "Rock", style: "Rock", min_members: 4, max_members: 6,
    skills: %w[Bass_Guitar Drummer Lead_Guitar Vocals]
  },
  { name: "Rock", style: "Ska", min_members: 4, max_members: 6,
    skills: %w[Bass_Guitar Drummer Keyboards Horns Vocals]
  },
  { name: "Soul", style: "Blues", min_members: 4, max_members: 6,
    skills: %w[Acoustic_Guitar Bass_Guitar Horns Vocals Wind]
  },
  { name: "Soul", style: "Funk", min_members: 5, max_members: 7,
    skills: %w[Acoustic_Guitar Bass_Guitar Drummer Keyboards Vocals Horns Wind Percussion Backup_Vocals]
  },
  { name: "Soul", style: "Hip Hop", min_members: 3, max_members: 5,
    skills: %w[DJ Drummer Rapping]
  },
  { name: "Soul", style: "Jazz", min_members: 4, max_members: 6,
    skills: %w[Acoustic_Guitar Bass_Guitar Drummer Horns Wind Keyboards]
  },
  { name: "Soul", style: "Rap", min_members: 2, max_members: 4,
    skills: %w[Dance DJ Rapping]
  },
  { name: "Soul", style: "Reggae", min_members: 3, max_members: 5,
    skills: %w[Acoustic_Guitar Drummer Dance Rapping]
  },
  { name: "Soul", style: "Raggae", min_members: 3, max_members: 5,
    skills: %w[Keyboards DJ Vocals]
  },
  { name: "Vocalist", style: "Barbership Quartet", min_members: 4, max_members: 4,
    skills: %w[Vocals]
  },
  { name: "Vocalist", style: "Solo", min_members: 1, max_members: 1,
    skills: %w[Vocals]
  }
]

seed_data.each do |seed|
  skills = seed.delete(:skills).map{|e| e.gsub('_',' ')}
  genre = Genre.where(name: seed[:name], style: seed[:style]).first_or_initialize
  genre.update(seed)

  # Add or remove skills found in the DB
  skills_found = genre.skills.pluck(:name)
  skills_removed = skills_found - skills
  skills_added = skills - skills_found

  skills_added.each do |skill|
    skill = Skill.where(name: skill).first_or_create
    genre.skills << skill
  end
  to_be_removed = Skill.where(name: skills_removed).to_a
  genre.skills.delete(to_be_removed)

  puts "  #{genre.name} / #{genre.style}".blue
end
puts

puts "Skills Found"
Skill.order(:name).each do |skill|
  puts "  #{skill.name}".blue
end
puts
