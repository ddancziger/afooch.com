class Picture < ActiveRecord::Base

	belongs_to :offer
	belongs_to :product

	has_attached_file :image,
	                  :path => ":rails_root/public/images/:style/:id/:filename",
	                  :url  => "/images/:style/:id/:filename",
	                  styles: {
			                  thumb: '60x60!',
			                  square: '200x200#',
			                  medium: '300x300>'
	                  }

	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


end
