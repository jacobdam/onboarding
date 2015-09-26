class CreateQuestionTemplates < ActiveRecord::Migration
  def change
    create_table :question_templates do |t|
      t.text :name
      t.string :worst_label
      t.string :best_label

      t.timestamps null: false
    end
  end
end
