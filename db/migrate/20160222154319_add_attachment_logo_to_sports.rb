class AddAttachmentLogoToSports < ActiveRecord::Migration
  def self.up
    change_table :sports do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :sports, :logo
  end
end
