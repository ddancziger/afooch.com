class OffersController < InheritedResources::Base

	def create
		@offer = Offer.new(offer_params)
		if current_user
			@offer.user_id = current_user.id
		end

		if params['product_id']
			@offer.product_id = params['product_id']
		end

		respond_to do |format|
			if @offer.save

				format.html { redirect_to product_path(@offer.product_id) }
				format.json { render :show, status: :created, location: @offer }
			else
				format.html { render :new }
				format.json { render json: @offer.errors, status: :unprocessable_entity }
			end
		end
	end

  private

    def offer_params
      params.require(:offer).permit(:title,:price,:expire,:product_id,:description,:condition)
    end
end

