class CreateQuinielas < ActiveRecord::Migration
  def change
    create_table :quinielas do |t|
	  t.text :initial_balance, :null => false
	  t.text :price
	  t.text :description
	  t.text :winner_number
      t.boolean :to_mainpage
	  t.references :game, index: true, :null => false
	  t.foreign_key :games, :on_delete => "cascade"
	  t.text :purchase_gift_tickets
	  t.text :last_question
       

      t.timestamps
    end
  end
end
