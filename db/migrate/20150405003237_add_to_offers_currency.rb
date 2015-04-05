class AddToOffersCurrency < ActiveRecord::Migration
  def change
	  add_column :offers, :currency, :string
  end
end
