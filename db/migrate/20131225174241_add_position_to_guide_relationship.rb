class AddPositionToGuideRelationship < ActiveRecord::Migration
  def change
    add_column :guide_relationships, :position, :integer
  end
end
