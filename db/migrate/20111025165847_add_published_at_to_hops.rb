class AddPublishedAtToHops < ActiveRecord::Migration

  def self.up
    add_column :hops, :published_at, :datetime
  end

  def self.down
    remove_column :hops, :published_at
  end
  
end
