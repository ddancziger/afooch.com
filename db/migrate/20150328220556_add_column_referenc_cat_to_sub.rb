class AddColumnReferencCatToSub < ActiveRecord::Migration
  def change
	  add_reference :subcategories, :category
  end
end
