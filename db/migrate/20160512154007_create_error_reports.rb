class CreateErrorReports < ActiveRecord::Migration
  def change
    create_table :error_reports do |t|
      t.references :user, index: true
      t.string :controller_name
      t.string :action_name
      t.string :line_number
      t.string :referrer_url
      t.string :original_path
      t.string :enviroment
      t.text :description
      t.text :backtrace
      t.datetime :error_time

      t.timestamps
    end
  end
end
