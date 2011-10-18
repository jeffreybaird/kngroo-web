class Trophy < ActiveRecord::Base

  belongs_to :user
  belongs_to :hop
  
  validates_presence_of :user_id, :hop_id
  
end
