class Offer < ActiveRecord::Base

	belongs_to :product
	belongs_to :user
	belongs_to :brand
	belongs_to :computer_spec, :dependent => :destroy
	belongs_to :camera_spec, :dependent => :destroy
	has_many :pictures, :dependent => :destroy
	accepts_nested_attributes_for :computer_spec
	accepts_nested_attributes_for :camera_spec
	accepts_nested_attributes_for :pictures


end
