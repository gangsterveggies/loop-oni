class Announcement < ActiveRecord::Base
  
  validates :message, presence: true

  def self.current_announcements(hide_time)
    with_scope :find => { :conditions => ["begin_date <= ? AND end_date >= ?", DateTime.now, DateTime.now] } do
      if hide_time.nil?
        find(:all)
      else
        find(:all, :conditions => ["updated_at > ? OR begin_date > ?", hide_time, hide_time])
      end
    end
  end
end
