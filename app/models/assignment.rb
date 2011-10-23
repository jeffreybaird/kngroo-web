class Assignment < ActiveRecord::Base

  belongs_to :user
  belongs_to :hop
  has_many :checkins
  
  validates_presence_of :user_id, :hop_id
  
end
