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
  
  has_attached_file :stamp,
    :storage => :s3, 
    :s3_credentials => "config/s3.yml",
    :s3_protocol => 'https',
    :path => "/hops/:id/stamp"
  
  default_scope :order => 'title asc'
  scope :published, where('published_at <= ?',Time.now)
  
  def published?
    published_at!=nil && published_at < Time.now  
  end
  
  def ready_for_publication?
    !venues.empty? && venues.reject {|v| Trivia.exists?(:hop_id => id, :venue_id => v.id)}.empty?
  end
  
end
