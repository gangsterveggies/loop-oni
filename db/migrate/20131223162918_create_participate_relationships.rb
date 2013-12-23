class CreateParticipateRelationships < ActiveRecord::Migration
  def change
    create_table :participate_relationships do |t|
      t.integer :user_id
      t.integer :contest_id

      t.timestamps
    end
    add_index :participate_relationships, :user_id
    add_index :participate_relationships, [:user_id, :contest_id], unique: true
  end
end
