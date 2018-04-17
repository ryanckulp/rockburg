require 'rails_helper'

RSpec.describe DailyRunningFinancialWorker, type: :worker do
  let(:member1) { create(:member, primary_skill: Skill.find_by_name('Keyboards')) }
  let(:member2) { create(:member, primary_skill: Skill.find_by_name('Drummer')) }
  let(:genre) { Genre.find_by_style('Drum & Bass') }
  let(:band) { create :band, genre: genre }

  before do
    band.add_member(member1, skill: member1.primary_skill)
    band.add_member(member2, skill: member2.primary_skill)
  end

  it 'successfully run this worker' do
    pre_balance = band.manager.balance

    Sidekiq::Testing.inline! do
      described_class.perform_async
    end
    band.manager.reload

    expect(band.manager.balance).to be < pre_balance
  end
end
