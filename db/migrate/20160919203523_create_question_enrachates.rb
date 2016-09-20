class CreateQuestionEnrachates < ActiveRecord::Migration
  def change
    create_table :question_enrachates do |t|
      t.text :title
      t.text :answer1
      t.text :answer2
      t.datetime :program_date

      t.timestamps
    end
  end
end
