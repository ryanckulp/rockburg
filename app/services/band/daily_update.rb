class Band::DailyUpdate < ApplicationService
  expects do
    required(:band).filled
  end

  delegate :band, to: :context

  before do
    context.band = Band.ensure(band)
  end

  def call
    calc_daily_running_costs(band)
  end

  def calc_daily_running_costs(band)
    # Daily running costs
    daily_running_costs = 0
    band.members.each do |member|
      daily_running_costs = daily_running_costs + member.cost_generator
    end

    # Rest
    Band::RemoveFatigue.(band: band, hours: 8)

    band.happenings.create(what: "#{band.name} spent §#{daily_running_costs} on daily running costs.")

    context.daily_running_costs = daily_running_costs
  end

  STREAMING_RATE = 0.03
  def calc_release_earnings(band)
    # Release earnings
    band.recordings.where.not(release_at:nil).each do |recording|
      days_since_release =  (Time.now.to_date - recording.release_at.to_date).to_i

      streams = recording.calc_streams - (band.fans * (days_since_release * 0.05))
      earnings = (streams * STREAMING_RATE).ceil

      context.earnings = earnings
      recording.increment!(:sales, earnings)
      band.happenings.create(what: "#{band.name} made §#{earnings} from streams of #{recording.name}.")
    end
  end

  def decay_buzz(band)
    # Decay buzz
    decayed_buzz = (band.buzz * 0.9).ceil
    band.update_attributes(buzz: decayed_buzz)
    band.happenings.create(what: "#{band.name}'s buzz decreased to #{decayed_buzz}.")
  end

  def decay_fans(band)
    # Decay fans
    decayed_fans = (band.fans * 0.9).ceil
    band.update_attributes(fans: decayed_fans)
    band.happenings.create(what: "#{band.name}'s fans decreased to #{decayed_fans}.")
  end
end
