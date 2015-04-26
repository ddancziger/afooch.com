class Users::RegistrationsController < Devise::RegistrationsController

	def create
		#render :text => "<pre>" + params[:user].to_s and return
		super
		# if params[:user][:image] and resource.save
		# 	resource.pictures.create(image: params[:user][:image])
		# end
	end

	def update

	#Update Avatar
		if params[:user][:avatar]
			@user.update_attribute(:avatar, params[:user][:avatar])
		end

		super

	end


	private

	def sign_up_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :city, :country, :gender, :birthday,:avatar)
	end
	protected

	def update_resource(resource, params)
		resource.update_without_password(params)
	end
end