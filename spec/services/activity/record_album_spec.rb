require 'rails_helper'

RSpec.describe Activity::RecordAlbum, type: :service do
  let(:member1) { create(:member, primary_skill: Skill.find_by_name('Keyboards')) }
  let(:member2) { create(:member, primary_skill: Skill.find_by_name('Drummer')) }
  let(:genre) { Genre.find_by_style('Drum & Bass') }
  let(:band) { create :band, genre: genre, fans: 100, buzz: 100 }
  let(:studio) { create :studio, cost: 1000}

  before do
    band.add_member(member1, skill: member1.primary_skill)
    band.add_member(member2, skill: member2.primary_skill)
    3.times do
      song = create :song, band: band
      Activity::RecordSingle.(band: band, studio: studio, song: song)
    end
  end

  it 'should record an album' do
    require 'sidekiq/testing'
    balance = band.manager.balance
    recording_ids = band.recordings.singles.ids
    expect(recording_ids.size).to eq(3)

    expect {
      Sidekiq::Testing.inline! do
        result = described_class.call(band: band, studio: studio, recording_ids: recording_ids)
        expect(result.success?).to eq(true)
        expect(result.activity).to be_present
      end
    }.to change{ band.recordings.albums.count }.by(1)

    band.manager.reload
    expect(balance).to be > band.manager.balance
  end
end
