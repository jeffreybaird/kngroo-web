class Category < ActiveRecord::Base

  has_many :hops
  
  validates_presence_of :title
  
  default_scope :order => "title asc"
  
end
