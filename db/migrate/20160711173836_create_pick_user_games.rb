class CreatePickUserGames < ActiveRecord::Migration
  def change
    create_table :pick_user_games do |t|
      t.references :pick_user, index: true, null: false
      t.references :team, index: true, null:false
      t.references :survivor_game, index: true, null:false

      t.timestamps
    end
  end
end
