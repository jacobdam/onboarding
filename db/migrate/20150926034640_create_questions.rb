class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :question_template, index: true, foreign_key: true
      t.references :check_point, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
