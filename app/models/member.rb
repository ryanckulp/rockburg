class Member < ApplicationRecord
  belongs_to :primary_skill, class_name: 'Skill', foreign_key: :skill_primary
  belongs_to :secondary_skill, class_name: 'Skill', foreign_key: :skill_secondary, optional: true
  belongs_to :tertiary_skill, class_name: 'Skill', foreign_key: :skill_tertiary, optional: true
  has_many :member_bands
  has_many :bands, through: :member_bands

  def age
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  def cost_generator
    skill_mp = 60
    creativity_mp = 25
    looks_mp = 15
    ego_mp = 50
    #network_mp = 30
    #drive_mp = 0.5
    #stamina_mp = 0.5
    #productivity_mp = 0.5
    #aptitude_mp = 0.8

    #possible_points = (100 * skill_mp) + (100 * network_mp) + (100 * creativity_mp) + (100 * drive_mp) + (100 * stamina_mp) + (100 * looks_mp) + (100 * productivity_mp) + (100 * aptitude_mp) - (100 * ego_mp)
    possible_points = (100 * skill_mp) + (100 * creativity_mp) + (100 * looks_mp)

    high_salary = 500

    points = skill_primary_level * skill_mp +
      trait_creativity * creativity_mp +
      trait_looks * looks_mp
    #trait_network * network_mp +
    #trait_drive * drive_mp +
    #trait_stamina * stamina_mp +
    #trait_productivity * productivity_mp +
    #trait_aptitude * aptitude_mp -

    ego_weight = (trait_ego * ego_mp).to_f / 10000
    full_salary = high_salary * (points.to_f / possible_points.to_f)
    ego_reduction = full_salary * ego_weight

    (full_salary - ego_reduction).round
  end

  def avatar
    seed = "#{id}#{birthdate.to_s.gsub('-','')}#{name.length}".to_i
    topType = ['NoHair','Eyepatch','Hat','Hijab','Turban','LongHairBigHair','LongHairBob','LongHairBun','LongHairCurly','LongHairCurvy','LongHairDreads','LongHairFrida','LongHairFro','LongHairFroBand','LongHairNotTooLong','LongHairShavedSides','LongHairMiaWallace','LongHairStraight','LongHairStraight2','LongHairStraightStrand','ShortHairDreads01','ShortHairDreads02','ShortHairFrizzle','ShortHairShaggyMullet','ShortHairShortCurly','ShortHairShortFlat','ShortHairShortRound','ShortHairShortWaved','ShortHairSides','ShortHairTheCaesar','ShortHairTheCaesarSidePart','WinterHat1','WinterHat2','WinterHat3','WinterHat4']
    accessoriesType = ['Blank','Blank','Blank','Blank','Blank','Blank','Blank','Blank','Blank','Kurt','Prescription01','Prescription02','Round','Sunglasses','Wayfarers']
    hairColor = ['Auburn','Black','Blonde','BlondeGolden','Brown','BrownDark','PastelPink','Platinum','Red','SilverGray']
    hatColor = ['Black','Blue01','Blue02','Blue03','Gray01','Gray02','Heather','PastelBlue','PastelGreen','PastelOrange','PastelRed','PastelYellow','Pink','Red','White']
    facialHairType = ['Blank','BeardMedium','BeardLight','BeardMagestic','MoustacheFancy','MoustacheMagnum']
    facialHairColor = ['Auburn','Black','Blonde','BlondeGolden','Brown','BrownDark','Platinum','Red']
    clotheType = ['BlazerShirt','BlazerSweater','CollarSweater','GraphicShirt','Hoodie','Overall','ShirtCrewNeck','ShirtScoopNeck','ShirtVNeck']
    clotheColor = ['Black','Blue01','Blue02','Blue03','Gray01','Gray02','Heather','PastelBlue','PastelGreen','PastelOrange','PastelRed','PastelYellow','Pink','Red','White']
    graphicType = ['Bat','Cumbia','Deer','Diamond','Hola','Pizza','Resist','Selena','Bear','SkullOutline','Skull']
    eyeType = ['Close','Cry','Default','Dizzy','EyeRoll','Happy','Side','Squint','Surprised','Wink','WinkWacky']
    eyebrowType = ['Angry','AngryNatural','Default','DefaultNatural','FlatNatural','RaisedExcited','RaisedExcitedNatural','SadConcerned','SadConcernedNatural','UnibrowNatural','UpDown','UpDownNatural']
    mouthType = ['Concerned','Default','Disbelief','Eating','Grimace','Sad','ScreamOpen','Serious','Smile','Tongue','Twinkle']
    skinColor = ['Tanned','Yellow','Pale','Light','Brown','DarkBrown','Black']

    url = "?topType=#{topType.sample(random: Random.new(seed+1))}&accessoriesType=#{accessoriesType.sample(random: Random.new(seed+2))}&hairColor=#{hairColor.sample(random: Random.new(seed+3))}&facialHairType=#{facialHairType.sample(random: Random.new(seed+4))}&facialHairColor=#{facialHairColor.sample(random: Random.new(seed+5))}&clotheType=#{clotheType.sample(random: Random.new(seed+6))}&clotheColor=#{clotheColor.sample(random: Random.new(seed+7))}&graphicType=#{graphicType.sample(random: Random.new(seed+8))}&eyeType=#{eyeType.sample(random: Random.new(seed+9))}&eyebrowType=#{eyebrowType.sample(random: Random.new(seed+10))}&mouthType=#{mouthType.sample(random: Random.new(seed+11))}&skinColor=#{skinColor.sample(random: Random.new(seed+12))}&hatColor=#{hatColor.sample(random: Random.new(seed+12))}"
    "https://avataaars.io/#{url}"
  end
end
