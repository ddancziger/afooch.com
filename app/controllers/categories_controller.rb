class CategoriesController < ApplicationController

	def products_categories
		@subcategories = Category.find_by_name(params[:category]).subcategories
	end
end
