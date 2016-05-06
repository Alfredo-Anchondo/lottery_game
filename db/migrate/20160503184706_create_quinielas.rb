class CreateQuinielas < ActiveRecord::Migration
  def change
    create_table :quinielas do |t|
	  t.text :initial_balance, :null => false
	  t.text :price
	  t.text :description
	  t.text :winner_number	
	  t.references :game, index: true, :null => false
	  t.foreign_key :games, :on_delete => "cascade"
      t.timestamps
    end
  end
end
