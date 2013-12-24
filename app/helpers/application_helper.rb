module ApplicationHelper
  def full_title(page_title)
    base_title = "Loop"
    if page_title.empty?
      "#{base_title}'ONI"
    else
      "#{base_title} | #{page_title}"
    end
  end

  def current_announcements
    if signed_in?
      @current_announcements ||= Announcement.current_announcements(current_user.announcement_hide_time)
    end
  end
end
