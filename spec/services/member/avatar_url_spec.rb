require 'rails_helper'

RSpec.describe Member::AvatarURL, type: :service do
  let(:member) { build_stubbed(:member) }

  it 'should return the same url for the same member' do
    r1 = described_class.call(member: member).result
    r2 = described_class.call(member: member).result
    expect(r1).not_to eq(nil)
    expect(r1).to eq(r2)
  end
end
