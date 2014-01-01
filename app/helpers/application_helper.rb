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

  def coderay(text)  
    text.gsub(/\<code( lang="(.+?)")?\>(.+?)\<\/code\>/m) do
      CodeRay.scan($3, $2).div(:css => :class, :line_numbers => :table)
    end
  end

  def pre2plain(text)
    text.gsub(/\<pre\>/m, '<div class="pre-plain">')
  end
end
