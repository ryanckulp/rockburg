require 'rails_helper'

RSpec.describe Member::Practice, type: :service do
  let(:member) { create(:member) }

  it 'should update stats' do
    orig_fatigue = member.trait_fatigue
    orig_level   = member.skill_primary_level
    context = described_class.call(member: member, hours: 6)
    expect(context.success?).to eq(true)
    expect(member.trait_fatigue).to be > orig_fatigue
    expect(member.skill_primary_level).to be > orig_level
  end

  it 'should require hours' do
    context = described_class.call(member: member)
    expect(context.failure?).to eq(true)
  end
end
