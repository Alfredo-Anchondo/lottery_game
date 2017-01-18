class CreateLotteries < ActiveRecord::Migration
  def change
    create_table :lotteries do |t|
      t.float :initial_balance, :null => false
      t.text :rules, :null => false
      t.text :description
      t.references :game, index: true, :null => false
      t.foreign_key :games
      t.boolean :to_mainpage
      t.integer :winner_number
      t.integer :initial_number, :null => false
      t.integer :final_number, :null => false
      t.float :price, :null => false
	    t.text :purchase_gift_tickets
      t.integer :game2_id

      t.timestamps
    end
  end
end
