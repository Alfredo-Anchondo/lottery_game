class CreateSportCategories < ActiveRecord::Migration
  def change
    create_table :sport_categories do |t|
      t.references :sport, index: true, :null => false
      t.foreign_key :sports, :on_delete => "cascade"
      t.references :category, index: true, :null => false
      t.foreign_key :categories, :on_delete => "cascade"

      t.timestamps
    end
  end
end
