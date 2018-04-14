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
    result = Band::HireMember.(band: params[:band_id], skill: params[:skill_id], member: params[:id])
    if result.success?
      redirect_to band_path(params[:band_id]), alert: "Member hired successfully."
    else
      redirect_to new_band_path, alert: result.message || "Error hiring member."
    end
  end
end
