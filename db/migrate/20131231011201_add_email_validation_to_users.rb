class AddEmailValidationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_validation_token, :string
    add_column :users, :email_validated_at, :datetime
  end
end
