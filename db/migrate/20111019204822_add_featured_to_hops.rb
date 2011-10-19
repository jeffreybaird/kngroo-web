class AddFeaturedToHops < ActiveRecord::Migration

  def self.up
    add_column :hops, :featured, :boolean
  end

  def self.down
    remove_column :hops, :featured
  end
  
end
