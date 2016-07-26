class CreatePickUserGames < ActiveRecord::Migration
  def change
    create_table :pick_user_games do |t|
      t.references :pick_user, index: true, null: false
	  t.foreign_key :pick_users	
      t.references :team, index: true, null:false
	  t.foreign_key :teams	
      t.references :survivor_game, index: true, null:false
	  t.foreign_key :survivor_games	
	  t.integer :points, null:false	

      t.timestamps
    end
  end
end
