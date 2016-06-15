class CreateSurvivorWeekGames < ActiveRecord::Migration
  def change
    create_table :survivor_week_games do |t|
      t.references :survivor, index: true, null:false
	  t.foreign_key :survivors
      t.date :initial_date, null:false
      t.date :final_date, null:false
      t.integer :week, null:false, default:1

      t.timestamps
    end
  end
end
