class Venue < ActiveRecord::Base

  has_many :memberships
  has_many :hops, :through => :memberships
  has_many :checkins
  
  validates_presence_of :name
  
end
