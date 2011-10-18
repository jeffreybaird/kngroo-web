class Hop < ActiveRecord::Base

  belongs_to :category
  has_many :memberships
  has_many :venues, :through => :memberships
  has_many :assignments
  has_many :users, :through => :assignments
  
  validates_presence_of :title, :description, :points
  validates_numericality_of :points
  
end
