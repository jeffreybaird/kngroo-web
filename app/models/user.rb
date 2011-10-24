class User < ActiveRecord::Base
  include Clearance::User
  
  has_role
  
  has_many :assignments
  has_many :hops, :through => :assignments
  has_many :checkins, :through => :assignments
  has_many :confirmations
  has_many :trophies
  
  before_create :reset_points
  before_create :generate_api_token

  def reset_points
    self.points = 0
  end
  
end
