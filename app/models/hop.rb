class Hop < ActiveRecord::Base

  belongs_to :category
  
  validates_presence_of :title, :description, :points
  validates_numericality_of :points
  
end
