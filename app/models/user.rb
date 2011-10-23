class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :assignments
  has_many :hops, :through => :assignments
  has_many :checkins
  has_many :confirmations
  has_many :trophies
  
  before_create :reset_points
  
  def reset_points
    self.points = 0
  end
  
end
