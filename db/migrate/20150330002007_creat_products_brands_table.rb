class CreatProductsBrandsTable < ActiveRecord::Migration
  def change
	  create_table :products_brands, id: false do |t|
		  t.integer :product_id
		  t.integer :brand_id
	  end
  end
end
