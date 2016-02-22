class CreateUserLotteries < ActiveRecord::Migration
  def change
    create_table :user_lotteries do |t|
      t.references :user, index: true, :null => false
      t.foreign_key :users
      t.references :lottery, index: true, :null => false
      t.foreign_key :lotteries
      t.string :status, :null => false
      t.integer :ticket_number, :null => false
      t.datetime :purchase_date, :null => false

      t.timestamps
    end
  end
end
