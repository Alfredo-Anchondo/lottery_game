class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => false
      t.string :last_name, :null => false
      t.string :address_1, :null => false
      t.string :address_2, :null => false
      t.string :zip_code, :null => false
      t.integer :age
      t.string :email, :null => false
      t.string :phone
      t.string :cellphone, :null => false
      t.float :balance
      t.references :role, index: true, :null => false
      t.foreign_key :roles
      t.string :country, :null => false
      t.string :state
      t.string :city
      t.integer :int_number
      t.integer :ext_number
      t.string :username, :null => false
      t.string :password

      t.timestamps
    end
  end
end
