class Checkin < ActiveRecord::Base

  belongs_to :user
  belongs_to :hop
  belongs_to :venue
  
  validates_presence_of :user_id, :hop_id, :venue_id
  
end
