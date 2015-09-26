class AddNameToQuestions < ActiveRecord::Migration
  def change
    change_table :questions do |t|
      t.text :name, null: false
    end
  end
end
