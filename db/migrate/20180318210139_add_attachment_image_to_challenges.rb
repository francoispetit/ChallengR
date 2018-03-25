class AddAttachmentImageToChallenges < ActiveRecord::Migration[5.1]
  def self.up
    change_table :challenges do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :challenges, :image
  end
end
