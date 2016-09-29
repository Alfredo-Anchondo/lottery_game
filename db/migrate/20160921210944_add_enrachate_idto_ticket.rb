class AddEnrachateIdtoTicket < ActiveRecord::Migration
  def change
       add_reference :enrachate_users, :enrachates, index: true, foreign_key: true
  end
end
