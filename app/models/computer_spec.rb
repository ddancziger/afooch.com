class ComputerSpec < ActiveRecord::Base

	has_many :products
	enum ram: ['1','2','4','6','8','12','16']
end
