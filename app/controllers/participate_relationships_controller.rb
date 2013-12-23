class ParticipateRelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @contest = Contest.find(params[:participate_relationship][:contest_id])
    current_user.participate!(@contest)
    respond_to do |format|
      format.html { redirect_to @contest }
      format.js
    end
  end

  def destroy
    @contest = ParticipateRelationship.find(params[:id]).contest
    current_user.unparticipate!(@contest)
    respond_to do |format|
      format.html { redirect_to @contest }
      format.js
    end
  end
end
