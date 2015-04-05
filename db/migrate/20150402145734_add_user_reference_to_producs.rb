class AddUserReferenceToProducs < ActiveRecord::Migration
  def change
	  add_reference :products, :user
  end
end
