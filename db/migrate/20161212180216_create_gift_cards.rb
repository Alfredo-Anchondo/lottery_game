class CreateGiftCards < ActiveRecord::Migration
  def change
    create_table :gift_cards do |t|
      t.float :value
      t.references :user, index: true
      t.string :code
      t.boolean :available

      t.timestamps
    end
  end
end
