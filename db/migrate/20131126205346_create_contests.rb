class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :title
      t.string :topic
      t.string :link
      t.integer :duration
      t.datetime :begin_date
      t.datetime :end_date

      t.timestamps
    end
    add_index :contests, :title
    add_index :contests, :topic
  end
end
