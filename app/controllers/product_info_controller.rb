class ProductInfoController < ApplicationController
	include Wicked::Wizard
	steps :product_info, :delivery_info

	def show
		@product = Product.find(session[:product_id])
		render_wizard
	end

	def update
		@product = Product.find(session[:product_id])
		params[:product][:status] = step
		params[:product][:status] = 'active' if step == steps.last
		@product.update_attributes(product_params)
		render_wizard @product
	end

	def product_params
		allow = [:title,:quantity,:minPrice, :maxPrice, :currency, :arrival, :numberArrival,:cityArrival,:countryArrival, :condition, :description, :category_id, :subcategory_id, :brands_id]
		params.require(:product).permit(allow)
	end
end
