class Assignment < ActiveRecord::Base

  belongs_to :user
  belongs_to :hop
  has_many :checkins
  
  validates_presence_of :user_id, :hop_id
  validate :can_only_have_one_active, :on => :create

  attr_accessible :hop_id

  default_scope :order => "created_at desc"
  scope :active, where(:complete => false)
  
  def can_only_have_one_active
    if Assignment.active.where(:user_id => user_id, :hop_id => hop_id).count>0
      errors.add(:hop, 'is already active')
    end
  end

end
