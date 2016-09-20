class CreateRelationEnrachateTiras < ActiveRecord::Migration
  def change
    create_table :relation_enrachate_tiras do |t|
      t.references :enrachate, index: true
      t.references :tira_enrachate, index: true

      t.timestamps
    end
  end
end
