class Venue < ActiveRecord::Base

  has_many :memberships
  has_many :hops, :through => :memberships
  
  validates_presence_of :name
  
end
