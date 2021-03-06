class Product < ActiveRecord::Base

	belongs_to :category
	belongs_to :subcategory
	belongs_to :computer_spec
	belongs_to :camera_spec
	belongs_to :user
	accepts_nested_attributes_for :computer_spec
	accepts_nested_attributes_for :camera_spec
	has_and_belongs_to_many :brand
	has_many :offers
	has_many :pictures, :dependent => :destroy
	accepts_nested_attributes_for :pictures
	enum condition: ['like new','used']
	enum arrival: ['day(s)','week(s)','month']
	enum currency: ['USD','NIS']

	#Validates Information
	validates :title, presence: true
	validates :quantity, presence: true, numericality: true, if: 'active_or_product?'
	validates :category, presence: true, if: "category_id.present?", if: 'active_or_product?'
	validates :minPrice, presence: true, numericality: true , if: 'active_or_delivery?'
	validates :maxPrice, presence: true, numericality: true , if: 'active_or_delivery?'
	validates :numberArrival, presence: true, numericality: true, if: 'active_or_delivery?'
	validates :cityArrival, presence: true, if: 'active_or_delivery?'

	# Validates depending on wich step user is in
	def active?
		status == 'active'
	end

	def active_or_product?
		(status || '').include?('product') || active?
	end

	def active_or_delivery?
		(status || '').include?('delivery') || active?
	end

	def self.search(search)
		find(:all, :conditions => ["title like ?", "%#{search}%"])
	end

	def price
		if self.maxPrice and self.minPrice
			(self.maxPrice + self.minPrice)/2
		elsif self.maxPrice and !self.minPrice
			self.maxPrice
		else
			self.minPrice
		end
	end
end
