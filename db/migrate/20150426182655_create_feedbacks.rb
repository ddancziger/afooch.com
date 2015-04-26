class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :shipping_time
      t.integer :matching
      t.integer :user_id

      t.timestamps
    end
  end
end
