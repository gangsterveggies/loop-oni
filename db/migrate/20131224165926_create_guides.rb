class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string :title
      t.text :description

      t.timestamps
    end

    add_index :guides, :title
    drop_table :add_announcements
  end
end
