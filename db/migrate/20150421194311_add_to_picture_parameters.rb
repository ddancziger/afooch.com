class AddToPictureParameters < ActiveRecord::Migration
  def change
		add_column :pictures, :image_content_type, :string
		add_column :pictures, :image_file_size, :integer
		add_column :pictures, :image_updated_at, :datetime
		add_column :pictures, :image_url, :string
  end
end
