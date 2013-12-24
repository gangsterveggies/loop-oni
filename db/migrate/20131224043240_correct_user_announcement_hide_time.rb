class CorrectUserAnnouncementHideTime < ActiveRecord::Migration
  def change
    remove_column :users, :announcement_hide_time, :integer
    add_column :users, :announcement_hide_time, :datetime
  end
end
