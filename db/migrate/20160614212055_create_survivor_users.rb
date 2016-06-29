class CreateSurvivorUsers < ActiveRecord::Migration
  def change
    create_table :survivor_users do |t|
      t.references :survivor_week_game, index: true, null:false
	  t.foreign_key :survivor_week_games
      t.references :team, index: true
	  t.foreign_key :teams
      t.datetime :purchase_date, null:false
      t.references :user, index: true, null:false
	  t.foreign_key :users
      t.string :status, null:false, default: "bought"

      t.timestamps
    end
  end
end
