class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name, :null => false
      t.string :description

      t.timestamps
    end
  end
end
