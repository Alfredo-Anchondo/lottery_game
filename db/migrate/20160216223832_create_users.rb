class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => false
      t.string :last_name, :null => false
      t.string :address_1
      t.string :address_2
      t.string :zip_code
      t.integer :age
      t.string :email, :null => false
      t.string :phone
      t.string :cellphone
      t.float :balance, :default => 0
      t.references :role, index: true, :null => false
      t.foreign_key :roles
      t.string :country
      t.string :state
      t.string :city
      t.integer :int_number
      t.integer :ext_number
      t.string :username, :null => false
      t.string :password
      t.string :favorite_team    
      t.date :birthday
      t.string :openpay_id    

      t.timestamps
    end
  end
end
