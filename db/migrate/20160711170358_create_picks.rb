class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.string :name, :null => false
      t.string :description
	  t.references :user, index: true, :null => false
      t.foreign_key :users
      t.float :price, :null => false, :default => 1
      t.float :initial_balance, :null => false, :default => 1
      t.string :access_key
      t.integer :users_quantity
      t.float :percentage

      t.timestamps
    end
  end
end
