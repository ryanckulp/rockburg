class SkillsController < ApplicationController
  def index
  end

  def show
    @skill = Skill.find(params[:id])
    @band = Band.find(params[:band_id])
  end
end
