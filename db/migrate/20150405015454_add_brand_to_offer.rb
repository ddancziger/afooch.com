class AddBrandToOffer < ActiveRecord::Migration
  def change
	  add_reference :offers, :brand
  end
end
