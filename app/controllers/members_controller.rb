class MembersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def hire
    @member_band = MemberBand.new(band_id: params[:band_id], skill_id: params[:skill_id], member_id: params[:id], joined_band_at: Time.now)
    if @member_band.save
      current_manager.financials.create!(amount: -@member_band.member.cost_generator, band_id: params[:band_id])
      @member_band.band.happenings.create(what: "#{@member_band.member.name} was hired to #{member_band.member.primary_skill.verb} #{@member_band.member.primary_skill.name}!")
      redirect_to band_path(params[:band_id]), alert: "Member hired successfully."
    else
      redirect_to new_band_path, alert: "Error hiring member."
    end
  end
end
