class Attempt < ActiveRecord::Base

  belongs_to :user
  belongs_to :trivia
  
  validates_presence_of :user_id, :trivia_id

end
