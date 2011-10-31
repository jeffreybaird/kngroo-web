class Hop < ActiveRecord::Base

  belongs_to :category
  has_many :memberships
  has_many :venues, :through => :memberships
  has_many :assignments
  has_many :users, :through => :assignments
  has_many :checkins, :through => :assignments
  has_many :trivias
  has_many :trophies
  
  validates_presence_of :title, :description, :points
  validates_numericality_of :points
  
  default_scope :order => 'title asc'
  scope :published, where('published_at <= ?',Time.now)
  
  def published?
    published_at!=nil && published_at < Time.now  
  end
  
end
