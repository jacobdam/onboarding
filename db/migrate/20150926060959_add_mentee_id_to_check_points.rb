class AddMenteeIdToCheckPoints < ActiveRecord::Migration
  def change
    change_table :check_points do |t|
      t.integer :mentee_id, null: false, index: true
    end

    remove_column :check_points, :company_id
  end
end
