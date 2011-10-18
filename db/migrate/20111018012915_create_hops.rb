class CreateHops < ActiveRecord::Migration
  def self.up
    create_table :hops do |t|
      t.string :title
      t.text :description
      t.integer :category_id
      t.integer :points

      t.timestamps
    end
  end

  def self.down
    drop_table :hops
  end
end
