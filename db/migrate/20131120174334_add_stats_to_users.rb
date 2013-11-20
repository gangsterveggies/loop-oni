class AddStatsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :qualifications, :integer
    add_column :users, :finals, :integer
    add_column :users, :iois, :integer
    add_column :users, :wins, :integer
    add_column :users, :bronze, :integer
    add_column :users, :silver, :integer
    add_column :users, :gold, :integer
  end
end
