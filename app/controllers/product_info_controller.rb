class ProductInfoController < ApplicationController
	include Wicked::Wizard
	before_action :authenticate_user!
	steps :product_info, :delivery_info

	def show
		@product = Product.find(session[:product_id])
		render_wizard
	end

	def update
		@product = Product.find(session[:product_id])
		params[:product][:status] = step.to_s
		params[:product][:status] = 'active' if step == steps.last
		#render :text => "<pre>" + Brand.find(params[:brands_id]).to_yaml and return
		case step
			when :product_info
				if params[:brands_id]
					@product.brand << Brand.find(params[:brands_id])
				end
		end
		@product.update_attributes(product_params)
		render_wizard @product
	end

	def product_params
		allow = [:title,:quantity,:minPrice, :maxPrice, :currency, :arrival, :numberArrival,:cityArrival,:countryArrival, :condition, :description, :category_id, :subcategory_id, :brands_id,:status]
		params.require(:product).permit(allow)
	end

	def finish_wizard_path
		product_path(@product.id)
	end
end
