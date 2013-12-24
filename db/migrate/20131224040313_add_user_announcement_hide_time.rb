class AddUserAnnouncementHideTime < ActiveRecord::Migration
  def change
    add_column :users, :announcement_hide_time, :integer
  end
end
