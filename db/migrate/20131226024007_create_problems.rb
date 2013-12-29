class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.string :link
      t.string :submit_link
      t.text :statement
      t.text :notes
      t.text :solution

      t.timestamps
    end

    add_index :problems, :title
  end
end
