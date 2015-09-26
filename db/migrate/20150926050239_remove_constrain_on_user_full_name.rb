class RemoveConstrainOnUserFullName < ActiveRecord::Migration
  def change
    change_column :users, :full_name, :string, null: true
  end
end
