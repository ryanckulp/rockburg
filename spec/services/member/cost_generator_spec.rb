require 'rails_helper'

RSpec.describe Member::CostGenerator, type: :service do
  it 'should return the same cost for the same member' do
    m = build_stubbed(:member)
    r1 = described_class.call(member: m).result
    r2 = described_class.call(member: m).result
    expect(r1).not_to eq(nil)
    expect(r1).to eq(r2)
  end
end
