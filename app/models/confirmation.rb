class Confirmation < ActiveRecord::Base

  belongs_to :trivia
  belongs_to :user
  
  validates_presence_of :trivia_id, :user_id
  
end
