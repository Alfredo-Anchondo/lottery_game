class CreateSurvivors < ActiveRecord::Migration
  def change
    create_table :survivors do |t|
      t.string :name, :null => false
      t.text :description
	  t.text :access_key
	  t.references :user, index: true, :null => false
      t.foreign_key :users
      t.float :price, :null => false, :default => 0
      t.float :initial_balance, :null => false, :default => 0

      t.timestamps
    end
  end
end
