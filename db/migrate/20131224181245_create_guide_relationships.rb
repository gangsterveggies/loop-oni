class CreateGuideRelationships < ActiveRecord::Migration
  def change
    create_table :guide_relationships do |t|
      t.integer :guide_id
      t.integer :article_id

      t.timestamps
    end

    add_index :guide_relationships, :guide_id
    add_index :guide_relationships, [:guide_id, :article_id], unique: true
  end
end
