class AddStampToHops < ActiveRecord::Migration

  def self.up
    add_column :hops, :stamp_name, :string
    add_column :hops, :stamp_file_name, :string
    add_column :hops, :stamp_content_type, :string
    add_column :hops, :stamp_file_size,    :integer
    add_column :hops, :stamp_updated_at,   :datetime
  end

  def self.down
    remove_column :hops, :stamp_name
    remove_column :hops, :stamp_file_name
    remove_column :hops, :stamp_content_type
    remove_column :hops, :stamp_file_size
    remove_column :hops, :stamp_updated_at
  end
  
end
