class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.string :name, :null => false
      t.string :description
	  t.references :user, index: true, :null => false
      t.foreign_key :users
	  t.references :sport_category, index: true, :null => false
      t.foreign_key :sport_categories
      t.float :price, :null => false, :default => 1
      t.float :initial_balance, :null => false, :default => 1
      t.string :access_key
      t.integer :users_quantity
      t.float :percentage
	  t.integer :type	
      t.timestamps
    end
  end
end
