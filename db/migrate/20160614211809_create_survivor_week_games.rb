class CreateSurvivorWeekGames < ActiveRecord::Migration
  def change
    create_table :survivor_week_games do |t|
      t.date :initial_date, null:false
      t.date :final_date, null:false
      t.integer :week, null:false, default:1
      t.boolean :closed, :default => false, :null => false
	  t.references :sport_category, index: true, :null => false
      t.foreign_key :sport_categories
      t.timestamps
    end
  end
end
