class AddUserToEnrachate < ActiveRecord::Migration
  def change
       add_reference :enrachates, :user, index: true, foreign_key: true
       add_column :enrachates, :access_key, :string
  end
end
