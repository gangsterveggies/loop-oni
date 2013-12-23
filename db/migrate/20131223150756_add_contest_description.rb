class AddContestDescription < ActiveRecord::Migration
  def change
    add_column :contests, :description, :text
  end
end
