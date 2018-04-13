after :genres do
  puts "Update Verbs on Skills"
  seed_data = {
    'sing' => ['Backup Vocals', 'Vocals'],
    nil => ['Dance','DJ','Rapping']
  }

  seed_data.each do |k,v|
    v.each do |skill_name|
      skill = Skill.ensure(skill_name)
      skill.verb = k
      skill.save
      puts "  #{skill.name} Verb(#{skill.verb})".blue
    end
  end
  puts
end