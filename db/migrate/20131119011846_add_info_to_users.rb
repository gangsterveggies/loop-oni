class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :type, :integer
    add_column :users, :graduation_year, :integer
    add_column :users, :school, :string
    add_column :users, :city, :string
  end
end
