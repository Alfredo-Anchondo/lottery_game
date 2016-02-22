class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, :null => false
      t.text :description
      t.boolean :is_admin
      t.boolean :is_client

      t.timestamps
    end
  end
end
