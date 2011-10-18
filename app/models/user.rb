class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :assignments
  has_many :hops, :through => :assignments
  has_many :checkins
  has_many :confirmations
  has_many :trophies
  
end
