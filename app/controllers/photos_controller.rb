class PhotosController < ApplicationController

	mount_uploader :image, AvatarUploader
	belongs_to :product
	belongs_to :offer

end
