class AddPhotosToOffer < ActiveRecord::Migration
  def change
		add_column :offers, :photos, :json
  end
end
