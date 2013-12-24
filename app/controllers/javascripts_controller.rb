class JavascriptsController < ApplicationController
  def hide_announcement
    if signed_in?
      @user = User.find(current_user.id)
      @user.announcement_hide_time = DateTime.now
      @user.save
      current_user = @user
      current_announcements = nil
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end
end
