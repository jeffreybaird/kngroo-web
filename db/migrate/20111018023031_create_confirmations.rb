class CreateConfirmations < ActiveRecord::Migration
  def self.up
    create_table :confirmations do |t|
      t.integer :trivia_id
      t.integer :user_id
      t.boolean :correct_answer

      t.timestamps
    end
  end

  def self.down
    drop_table :confirmations
  end
end
