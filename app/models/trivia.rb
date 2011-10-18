class Trivia < ActiveRecord::Base

  belongs_to :hop
  belongs_to :venue
  
  validates_presence_of :hop_id, :venue_id, :question, :answer
  
end
