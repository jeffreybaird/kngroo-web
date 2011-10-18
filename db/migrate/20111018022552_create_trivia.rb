class CreateTrivia < ActiveRecord::Migration
  def self.up
    create_table :trivia do |t|
      t.integer :hop_id
      t.integer :venue_id
      t.text :question
      t.string :answer
      t.boolean :numeric_answer

      t.timestamps
    end
  end

  def self.down
    drop_table :trivia
  end
end
