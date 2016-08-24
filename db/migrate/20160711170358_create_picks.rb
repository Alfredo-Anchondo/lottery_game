class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.string :name, :null => false
      t.string :description
      t.boolean :to_mainpage    
	  t.references :user, index: true, :null => false
      t.foreign_key :users
	  t.references :sport_category, index: true, :null => false
      t.foreign_key :sport_categories
      t.float :price, :null => false, :default => 1
      t.float :initial_balance, :null => false, :default => 1
      t.string :access_key
      t.integer :users_quantity
      t.float :percentage, :default => 0
	  t.integer :pick_type
      t.integer :winner_type    
      t.float :percentage_per_week,  :default => 0 
      t.float :first_percentage  
      t.float :second_percentage  
      t.float :third_percentage  
      t.timestamps
    end
  end
end
