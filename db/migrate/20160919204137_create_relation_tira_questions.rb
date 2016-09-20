class CreateRelationTiraQuestions < ActiveRecord::Migration
  def change
    create_table :relation_tira_questions do |t|
      t.references :tira_enrachate, index: true
      t.references :question_enrachate, index: true

      t.timestamps
    end
  end
end
