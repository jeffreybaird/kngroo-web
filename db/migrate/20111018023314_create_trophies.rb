class CreateTrophies < ActiveRecord::Migration
  def self.up
    create_table :trophies do |t|
      t.integer :hop_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :trophies
  end
end
