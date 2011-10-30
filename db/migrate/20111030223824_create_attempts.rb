class CreateAttempts < ActiveRecord::Migration
  def self.up
    create_table :attempts do |t|
      t.integer :trivia_id
      t.integer :user_id
      t.boolean :correct_answer, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :attempts
  end
end
