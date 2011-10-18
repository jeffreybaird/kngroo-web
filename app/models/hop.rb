class Hop < ActiveRecord::Base

  belongs_to :category
  has_many :memberships
  has_many :venues, :through => :memberships
  
  validates_presence_of :title, :description, :points
  validates_numericality_of :points
  
end
