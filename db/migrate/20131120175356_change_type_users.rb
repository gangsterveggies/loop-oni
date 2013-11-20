class ChangeTypeUsers < ActiveRecord::Migration
  def change
    remove_column :users, :type, :integer
    add_column :users, :contestant_type, :integer
  end
end
