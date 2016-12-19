class CreateEnrachates < ActiveRecord::Migration
  def change
    create_table :enrachates do |t|
      t.float :price
      t.float :initial_balance
      t.float :percentage
      t.integer :type_enrachate
      t.text :description
      t.integer :winner
      t.datetime :initial_date
      t.datetime :end_date
      t.string :name
      t.float :second_prize
      t.float :third_prize
      t.integer :max_racha

      t.timestamps
    end
  end
end
