class CreateProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.string :title
      t.integer :quantity
      t.string :status
      t.text :description
      t.string :arrival
      t.integer :minPrice
      t.integer :maxPrice
      t.string :condition

      t.timestamps
    end
  end
end
