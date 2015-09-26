class CreateMentees < ActiveRecord::Migration
  def change
    create_table :mentees do |t|
      t.string :name
      t.string :email
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
