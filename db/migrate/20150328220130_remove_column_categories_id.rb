class RemoveColumnCategoriesId < ActiveRecord::Migration
  def change
	  remove_column :subcategories, :categories_id

  end
end
