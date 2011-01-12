class AddFriendlyIdToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.string :cached_slug
      t.index :cached_slug, :unique => true
    end
  end

  def self.down
    change_table :posts do |t|
      t.remove :cached_slug
      t.remove_index :cached_slug
    end
  end
end
