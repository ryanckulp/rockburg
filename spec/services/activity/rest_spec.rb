require 'rails_helper'

RSpec.describe Activity::Rest, type: :service do
  let(:member1) { create(:member, primary_skill: Skill.find_by_name('Keyboards')) }
  let(:member2) { create(:member, primary_skill: Skill.find_by_name('Drummer')) }
  let(:genre) { Genre.find_by_style('Drum & Bass') }
  let(:band) { create :band, genre: genre }

  before do
    band.add_member(member1, skill: member1.primary_skill, trait_fatigue: 50)
    band.add_member(member2, skill: member2.primary_skill, trait_fatigue: 50)
  end

  it 'should rest a bit' do
    require 'sidekiq/testing'
    m1_fatigue = member1.trait_fatigue
    m2_fatigue = member2.trait_fatigue

    Sidekiq::Testing.inline! do
      result = described_class.call(band: band, hours: 1)
      expect(result.success?).to eq(true)
      expect(result.activity).to be_present
    end

    member1.reload
    member2.reload
    expect(member1.trait_fatigue).to be < m1_fatigue
    expect(member2.trait_fatigue).to be < m2_fatigue
  end
end
