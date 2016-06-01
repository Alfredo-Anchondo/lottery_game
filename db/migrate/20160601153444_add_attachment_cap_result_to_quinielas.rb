class AddAttachmentCapResultToQuinielas < ActiveRecord::Migration
  def self.up
    change_table :quinielas do |t|
      t.attachment :cap_result
    end
  end

  def self.down
    remove_attachment :quinielas, :cap_result
  end
end
