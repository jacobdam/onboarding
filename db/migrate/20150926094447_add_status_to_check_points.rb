class AddStatusToCheckPoints < ActiveRecord::Migration
  def change
    change_table :check_points do |f|
      f.integer :status, null: false, default: 0
    end
  end
end
