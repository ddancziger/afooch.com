class Product < ActiveRecord::Base

	belongs_to :category
	belongs_to :subcategory
	enum condition: ['like new','used']
	enum arrival: ['day(s)','week(s)','month']
	enum currency: ['USD','NIS']


end
