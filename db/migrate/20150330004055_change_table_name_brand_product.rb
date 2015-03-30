class ChangeTableNameBrandProduct < ActiveRecord::Migration
  def change
	  rename_table :products_brands, :brands_products
  end
end
