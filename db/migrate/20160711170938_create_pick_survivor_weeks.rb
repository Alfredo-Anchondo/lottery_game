class CreatePickSurvivorWeeks < ActiveRecord::Migration
  def change
    create_table :pick_survivor_weeks do |t|
      t.references :pick, index: true, null: false
      t.references :survivor_week_game, index: true, null: false
      t.foreign_key :picks	
	  t.foreign_key :survivor_week_games	

      t.timestamps
    end
  end
end
