class AddArrivalTimeProducts < ActiveRecord::Migration
  def change
	  add_column :products, :cityArrival, :string
	  add_column :products, :countryArrival, :string
	  add_column :products, :numberArrival, :integer
  end
end
