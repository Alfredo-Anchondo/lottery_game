class CreateEnrachates < ActiveRecord::Migration
  def change
    create_table :enrachates do |t|
      t.float :price
      t.float :initial_balance
      t.float :percentage
      t.integer :type
      t.text :description
      t.integer :winner
      t.datetime :initial_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
