class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
			t.integer :user_id
			t.integer :product_id
			t.integer :price
			t.integer :arrivalTime
			t.string  :arrival
			t.string  :title
			t.string :condition
			t.text :description
			t.string :return_policy
			t.datetime :expire
			t.string :guarantee


      t.timestamps
    end
  end
end
