class CreateReadRelationships < ActiveRecord::Migration
  def change
    create_table :read_relationships do |t|
      t.integer :user_id
      t.integer :article_id

      t.timestamps
    end
    add_index :read_relationships, :user_id
    add_index :read_relationships, [:user_id, :article_id], unique: true
  end
end
