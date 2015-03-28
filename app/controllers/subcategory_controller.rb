class SubcategoryController < ApplicationController

	def get_subcategories
		cat = Category.find(params[:cat_id])
		if cat
				sub =  cat.subcategories.all.to_a
				select_box = ""
				sub.each do |category|

					select_box += '<option value="'+category.id.to_s+'">'+category.name+'</option>'
				end
				render :text => select_box
		end
	end
end
