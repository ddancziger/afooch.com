class AddRoleBirthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    add_column :users, :birthday, :date
  end
end
