class OffersController < InheritedResources::Base
	before_action :set_offer, only: [:edit, :update, :destroy]
	def new
		@offer = Offer.new
		@offer.build_computer_spec
		@offer.build_camera_spec

	end

	def create

		#Saving Parameters Depending on Which SubCategory -> Specs Of the Offer!
		@offer = Offer.new(offer_params(params[:subcategory_id]))

		#Saving the current user to the offer
		if current_user
			@offer.user_id = current_user.id
		end

		#Connecting the Offer to the Product
		if params['product_id']
			@offer.product_id = params['product_id']
		end

		#render :text => "<pre>" + params[:offer][:images].to_s and return
		respond_to do |format|
			if @offer.save
				if params[:offer][:images]
					# The magic is here ;)
					params[:offer][:images].each { |image|
						@offer.pictures.create(image: image)
					}
				end
				format.html { redirect_to product_path(@offer.product_id) }
				format.json { render :show, status: :created, location: @offer }
			else
				format.html { render :new }
				format.json { render json: @offer.errors, status: :unprocessable_entity }
			end
		end
	end


	def update
		#render :text => "<pre>" + offer_params(@offer.product.subcategory_id.to_s).to_s and return
		respond_to do |format|

			if @offer.update(offer_params(@offer.product.subcategory_id.to_s))
				format.html { redirect_to  @offer, notice: 'Offer was successfully updated.' }
				format.json { render :show, status: :ok, location: @offer }
			else
				format.html { render :edit }
				format.json { render json: @offer.errors, status: :unprocessable_entity }
			end
		end
	end


  private
		# Use callbacks to share common setup or constraints between actions.
		def set_offer
			@offer = Offer.find(params[:id])
		end
		#Permit Params to save or manipulate depending which type of specs we need
		def offer_params sub_category
			if sub_category.eql?('1')
				params.require(:offer).permit(:title,:price,:expire,:product_id,:description,:condition,:currency,:brand_id,
				                              computer_spec_attributes: [:hard,:ram,:processor,:monitor])
			else
				params.require(:offer).permit(:title,:price,:expire,:product_id,:description,:condition,:currency,:brand_id,
				                              camera_spec_attributes: [:mega_pixel,:type,:optical_zoom])
			end
		end

end

