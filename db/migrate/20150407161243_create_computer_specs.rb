class CreateComputerSpecs < ActiveRecord::Migration
  def change
    create_table :computer_specs do |t|
      t.integer :product_id
      t.integer :offer_id
      t.string :processor
      t.integer :ram
      t.string :hard
      t.integer :monitor

      t.timestamps
    end
  end
end
