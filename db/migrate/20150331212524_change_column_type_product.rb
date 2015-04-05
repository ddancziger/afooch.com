class ChangeColumnTypeProduct < ActiveRecord::Migration
  def change
	  change_column :products, :condition, :integer
	  change_column :products, :currency, :integer
	  change_column :products, :arrival, :integer
  end
end
