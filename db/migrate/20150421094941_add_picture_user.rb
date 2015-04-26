class AddPictureUser < ActiveRecord::Migration
  def change
		add_column :pictures, :user_id, :integer
		remove_column :users, :photo
  end
end
