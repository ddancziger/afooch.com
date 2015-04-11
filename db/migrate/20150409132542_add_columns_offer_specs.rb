class AddColumnsOfferSpecs < ActiveRecord::Migration
  def change
	  add_column :offers, :computer_spec_id, :integer
	  add_column :offers, :camera_spec_id, :integer
  end
end
