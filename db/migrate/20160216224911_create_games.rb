class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :team, index: true
      t.foreign_key :teams   
      t.datetime :game_date, :null => false
      t.text :description
      t.integer :local_score
      t.integer :visit_score
      t.integer :team2_id

      t.timestamps
    end
  end
end
