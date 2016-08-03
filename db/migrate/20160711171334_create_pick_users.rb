class CreatePickUsers < ActiveRecord::Migration
  def change
    create_table :pick_users do |t|
      t.references :user, index: true
	  t.foreign_key :users
      t.references :pick_survivor_week, index: true
	  t.foreign_key :pick_survivor_weeks	
      t.float :points
      t.text :status    
      t.integer :local_score
      t.integer :visit_score
      t.references :pick_user, index: true
      t.foreign_key :pick_users	
      t.timestamps
    end
  end
end
