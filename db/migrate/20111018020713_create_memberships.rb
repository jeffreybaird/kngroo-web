class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer :hop_id
      t.integer :venue_id

      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
