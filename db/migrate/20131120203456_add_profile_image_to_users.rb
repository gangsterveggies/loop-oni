class AddProfileImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_image, :string, default: "placeholder.png"
  end
end
