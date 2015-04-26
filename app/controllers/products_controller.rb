class ProductsController < ApplicationController

  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:index,:show]
  skip_before_action :set_product, only: [:my_products,:products_search]

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  def test
	  #render :text => "<pre>" + params.to_yaml and return

	  i = 0
	  rams = Array.new
	  ComputerSpec.rams.keys.each do |ram|
		  if params['ram_'+ComputerSpec.rams[ram].to_s] != '' and params['ram_'+ComputerSpec.rams[ram].to_s]
				rams[i] = params['ram_'+ComputerSpec.rams[ram].to_s]

				i += 1
		  end
	  end
	   @computers = Product.where(subcategory_id: 1).where(computer_spec: ComputerSpec.where(ram: rams))
			#@computers = Product.where(subcategory_id: 1).where(computer_spec: ComputerSpec.where(ram: params[:ram]))
		#render :text => "<pre>" + @computers.count.to_s and return


  end
  #Controller for searching products on the category or without
  def products_search
	  #render :text => "<pre>" + params.to_yaml and return
		@products = Product.where("title like ?", "%#{params[:search]}%")
		@products = @products.where(category_id: params[:category_id]) if params[:category_id] != ''
		#render :text => "<pre>" + @products.to_yaml and return
  end

  def products_subcategory
		products_scope = Product.where(subcategory_id: params[:subcategory])

		products_scope = products_scope.where(condition: Product.conditions[params[:condition]]) if params[:condition] and params[:condition] != ''

		products_scope = products_scope.where("minPrice > ?", params[:minPrice])  if params[:minPrice] != '' and params[:minPrice]
		products_scope = products_scope.where("maxPrice < ?", params[:maxPrice])  if params[:maxPrice] != '' and params[:maxPrice]

		i = 0
		rams = Array.new
		ComputerSpec.rams.keys.each do |ram|
			if params['ram_'+ComputerSpec.rams[ram].to_s] != '' and params['ram_'+ComputerSpec.rams[ram].to_s]
				rams[i] = params['ram_'+ComputerSpec.rams[ram].to_s]
				ram_enter = true
				i += 1
			end
		end
		if i > 0
			products_scope = products_scope.where(computer_spec: ComputerSpec.where(ram: rams))
		end

		#products_scope = products_scope.computer_specs.where(ram: params[:ram])  if params[:ram] != ''
		@products = smart_listing_create :products, products_scope, partial: "products/list"
		#render :text => "<pre>" + @products.to_yaml and return
  end

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    #render :text => "<pre>" + @products.to_yaml and return
  end

  # GET /products/1
  # GET /products/1.json
  def show
		@product = Product.find(params[:id])
  end

  def my_products
		userId = current_user[:id]

    @products = Product.all.where(user_id: userId)
		#render :text => "<pre>" + @products.to_yaml and return
		render layout: "user"
  end


  # GET /products/new
  def new
    @product = Product.new
		@product.build_computer_spec
		@product.build_camera_spec
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json

  def create
	  #render :text => "<pre>" + params[:product][:subcategory_id].to_s and return
		if params[:product][:subcategory_id] === '1'
      @product = Product.new(product_params_computer)
    else
			@product = Product.new(product_params_camera)
		end
    # @brands = Brand.where(id: product_params[:brands_id])
    # @product.brand << @brands
    if current_user
			@product.user_id = current_user.id
    end
    if params[:brands_id]
	    @product.brand << Brand.find(params[:brands_id])
    end
    #computer = @product.computer_spec.build
    respond_to do |format|
      if @product.save
	      if params[:product][:images]
		      # The magic is here ;)
		      params[:product][:images].each { |image|
			      @product.pictures.create(image: image)
		      }
	      end
	      #render :text => "<pre>" + @product.id.to_s and return
				#session[:product_id] = @product.id
        format.html { redirect_to product_path(@product.id) }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
	  #render :text => "<pre>" + params[:product][:brands_id].to_s and return

	  if params[:product][:subcategory_id] == '1'
		  product_params = product_params_computer
	  else
		  product_params = product_params_camera
	  end

	  respond_to do |format|

      if @product.update(product_params)
				if params[:product][:brands_id]
	        @product.update(brand: Brand.find(params[:product][:brands_id]))
	      end
        format.html { redirect_to  @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params_computer
	    allow = [:title,:quantity,:minPrice, :maxPrice, :currency, :arrival, :numberArrival,:cityArrival,:countryArrival, :condition, :description, :category_id, :subcategory_id, :brands_id,
	    computer_spec_attributes: [:hard,:ram,:processor,:monitor]]
	    params.require(:product).permit(allow)
    end

	  def product_params_camera
		  allow = [:title,:quantity,:minPrice, :maxPrice, :currency, :arrival, :numberArrival,:cityArrival,:countryArrival, :condition, :description, :category_id, :subcategory_id, :brands_id,
		           camera_spec_attributes: [:mega_pixel,:type,:optical_zoom]]
		  params.require(:product).permit(allow)
	  end

end
