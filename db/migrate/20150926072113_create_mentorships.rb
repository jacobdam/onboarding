class CreateMentorships < ActiveRecord::Migration
  def change
    create_table :mentorships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :mentee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
