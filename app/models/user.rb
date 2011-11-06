class User < ActiveRecord::Base
  include Clearance::User
  
  has_role
  
  has_many :assignments
  has_many :hops, :through => :assignments
  has_many :checkins, :through => :assignments, :order => "checkins.created_at desc"
  has_many :confirmations
  has_many :trophies, :order => "created_at desc"
  
  validates_presence_of :first_name, :last_name
  
  before_create :reset_points
  before_create :generate_api_token

  def reset_points
    self.points = 0
  end
  
  def generate_api_token
    self.api_token = Digest::SHA1.hexdigest("--#{email}--#{Time.now}--")[0..9]
  end
  
end
