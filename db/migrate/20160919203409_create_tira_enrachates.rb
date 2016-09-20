class CreateTiraEnrachates < ActiveRecord::Migration
  def change
    create_table :tira_enrachates do |t|
      t.datetime :program_date
      t.text :name

      t.timestamps
    end
  end
end
