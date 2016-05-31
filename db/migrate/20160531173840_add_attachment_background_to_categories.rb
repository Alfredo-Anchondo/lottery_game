class AddAttachmentBackgroundToCategories < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.attachment :background
    end
  end

  def self.down
    remove_attachment :categories, :background
  end
end
