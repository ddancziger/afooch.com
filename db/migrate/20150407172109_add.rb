class Add < ActiveRecord::Migration
  def change
	  add_column :products, :computer_spec_id, :integer
		add_column :products, :camera_spec_id, :integer
  end
end
