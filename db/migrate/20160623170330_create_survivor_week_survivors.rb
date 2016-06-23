class CreateSurvivorWeekSurvivors < ActiveRecord::Migration
  def change
    create_table :survivor_week_survivors do |t|
      t.references :survivor, index: true, :null => false
      t.references :survivor_week_game, index: true, :null => false
	  t.foreign_key :survivors
	  t.foreign_key :survivor_week_games
      t.timestamps
    end
  end
end
