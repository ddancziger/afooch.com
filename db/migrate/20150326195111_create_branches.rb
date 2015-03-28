class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :companyName

      t.timestamps
    end
  end
end
