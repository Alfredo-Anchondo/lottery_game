class AddAttachmentBackgroundToSurvivors < ActiveRecord::Migration
  def self.up
    change_table :survivors do |t|
      t.attachment :background
    end
  end

  def self.down
    remove_attachment :survivors, :background
  end
end
