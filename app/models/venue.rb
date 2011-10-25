class Venue < ActiveRecord::Base

  has_many :memberships
  has_many :hops, :through => :memberships
  has_many :checkins
  has_many :trivias
  
  validates_presence_of :name
  
  default_scope :order => "name asc"

end
