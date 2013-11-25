class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :content
      t.string :title

      t.timestamps
    end
    add_index :articles, [:title]
  end
end
