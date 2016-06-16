class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, :null => false
      t.string :description
      t.references :sport_category, index: true
      t.foreign_key :sport_categories

      t.timestamps
    end
  end
end
