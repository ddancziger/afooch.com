class AddReferencesCatSubProduct < ActiveRecord::Migration
  def change

	  add_reference :products, :category
	  add_reference :products, :subcategory
  end
end
