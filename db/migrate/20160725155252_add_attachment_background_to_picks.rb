class AddAttachmentBackgroundToPicks < ActiveRecord::Migration
  def self.up
    change_table :picks do |t|
      t.attachment :background
    end
  end

  def self.down
    remove_attachment :picks, :background
  end
end
