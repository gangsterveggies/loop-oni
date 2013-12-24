class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :message
      t.datetime :begin_date
      t.datetime :end_date

      t.timestamps
    end
    
    add_index :announcements, :begin_date
  end
end
