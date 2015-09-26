class CreateCheckPoints < ActiveRecord::Migration
  def change
    create_table :check_points do |t|
      t.datetime :started_at
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
