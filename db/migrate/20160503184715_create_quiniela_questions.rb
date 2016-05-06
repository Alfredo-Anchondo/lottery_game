class CreateQuinielaQuestions < ActiveRecord::Migration
  def change
    create_table :quiniela_questions do |t|
		t.references :question, index: true, :null => false
		t.foreign_key :questions, :on_delete => "cascade"
		t.references :quiniela, index: true, :null => false
		t.foreign_key :quinielas, :on_delete => "cascade"
		t.text :value
        t.timestamps
    end
  end
end
