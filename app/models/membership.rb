class Membership < ActiveRecord::Base

  belongs_to :hop
  belongs_to :venue
  
  validates_presence_of :hop_id
  
  accepts_nested_attributes_for :venue

end
