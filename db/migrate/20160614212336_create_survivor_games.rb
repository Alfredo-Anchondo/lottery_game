class CreateSurvivorGames < ActiveRecord::Migration
  def change
    create_table :survivor_games do |t|
      t.references :team, index: true, null:false
	    t.foreign_key :teams
      t.references :team2, index: true, null:false
      t.integer :handicap
      t.integer :plus_handicap
      t.text :description 
      t.text :type_update    
      t.datetime :game_date, null:false
      t.integer :winner_team
	    t.integer :local_score
	    t.integer :visit_score
      t.references :survivor_week_game, index: true
	    t.foreign_key :survivor_week_games
      t.timestamps
    end
	  add_foreign_key :survivor_games, :teams, column: :team2_id, name: :survivor_games_team2_id_fk
  end
end
