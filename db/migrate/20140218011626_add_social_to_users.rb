class AddSocialToUsers < ActiveRecord::Migration
  def change
    add_column :users, :codeforces, :string
    add_column :users, :topcoder, :string
    add_column :users, :blog, :string
  end
end
