class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :assignments
  has_many :hops, :through => :assignments
  
end
