class AddCategoryRefToSubcategory < ActiveRecord::Migration
		def change
			add_reference :subcategories, :categories, index: true
		end
end
