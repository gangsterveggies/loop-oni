class AddPdfToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :attach_file_name,    :string
    add_column :articles, :attach_content_type, :string
    add_column :articles, :attach_file_size,    :integer
    add_column :articles, :attach_updated_at,   :datetime
  end
end
