class CreateCameraSpecs < ActiveRecord::Migration
  def change
    create_table :camera_specs do |t|
      t.integer :offer_id
      t.integer :product_id
      t.integer :mega_pixel
      t.string :type
      t.integer :optical_zoom

      t.timestamps
    end
  end
end
