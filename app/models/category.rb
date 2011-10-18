class Category < ActiveRecord::Base

  has_many :hops
  
  validates_presence_of :title
  
end
