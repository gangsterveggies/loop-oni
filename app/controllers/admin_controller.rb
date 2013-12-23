class AdminController < ApplicationController
  before_action :admin_user

  def panel
  end

  def gen_contest_tool
    @contests = Contest.all
    unless params[:type].nil?
      @contest = Contest.find(params[:type])
      @users = @contest.users_participate
    end
  end
end
