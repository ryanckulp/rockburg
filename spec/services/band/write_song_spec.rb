require 'rails_helper'

RSpec.describe Band::WriteSong, type: :service do
  let(:member1) { create(:member) }
  let(:member2) { create(:member) }
  let(:genre) { Genre.find_by_style('Drum & Bass') }
  let(:band) { create :band, genre: genre, members: [member1, member2] }

  it 'should update stats' do
    expect {
      described_class.call(band: band)
    }.to change { band.songs.count }.by(1)
  end
end
