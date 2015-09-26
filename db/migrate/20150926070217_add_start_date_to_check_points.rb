class AddStartDateToCheckPoints < ActiveRecord::Migration
  def change
    change_table :check_points do |t|
      t.date :start_date, null: false
    end
  end
end
