class CreateQuinielaUsers < ActiveRecord::Migration
  def change
    create_table :quiniela_users do |t|
	  t.references :user, index: true, :null => false
	  t.foreign_key :users, :on_delete => "cascade"
	  t.references :quiniela, index: true, :null => false
	  t.foreign_key :quinielas, :on_delete => "cascade"	
	  t.text :ticket_number	, :null => false
	  t.text :status
	  t.datetime :purchase_date, :null => false
      t.timestamps
    end
  end
end
