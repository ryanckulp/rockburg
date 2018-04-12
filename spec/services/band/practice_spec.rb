require 'rails_helper'

RSpec.describe Band::Practice, type: :service do
  let(:member1) { create(:member) }
  let(:member2) { create(:member) }

  let(:band) { create :band, members: [member1, member2] }

  it 'should update stats' do
    orig_fatigue = [member1.trait_fatigue, member2.trait_fatigue]
    orig_level   = [member1.skill_primary_level, member2.skill_primary_level]

    context = described_class.call(band: band, hours: 6)

    expect(context.success?).to eq(true)
    expect(member1.trait_fatigue).to be > orig_fatigue[0]
    expect(member1.skill_primary_level).to be > orig_level[0]
    expect(member2.trait_fatigue).to be > orig_fatigue[1]
    expect(member2.skill_primary_level).to be > orig_level[1]
  end

  it 'should require hours' do
    context = described_class.call(band: band)
    expect(context.failure?).to eq(true)
  end
end
