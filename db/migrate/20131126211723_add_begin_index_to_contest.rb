class AddBeginIndexToContest < ActiveRecord::Migration
  def change
    add_index :contests, :begin_date
  end
end
