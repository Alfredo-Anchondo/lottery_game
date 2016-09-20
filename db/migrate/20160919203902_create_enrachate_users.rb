class CreateEnrachateUsers < ActiveRecord::Migration
  def change
    create_table :enrachate_users do |t|
      t.references :question_enrachate, index: true
      t.references :tira_enrachate, index: true
      t.text :answer
      t.references :user, index: true
      t.text :status
      t.datetime :purchase_date
      t.integer :enrachate_user_id
      t.timestamps
    end
  end
end
