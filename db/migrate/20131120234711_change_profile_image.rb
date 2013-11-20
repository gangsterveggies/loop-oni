class ChangeProfileImage < ActiveRecord::Migration
  def change
    remove_column :users, :profile_image, :string, default: "placeholder.png"
    add_column :users, :profile_image, :string
  end
end
