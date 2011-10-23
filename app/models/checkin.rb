class Checkin < ActiveRecord::Base

  belongs_to :assignment
  belongs_to :venue
  
  validates_presence_of :assignment_id, :venue_id
  validates_uniqueness_of :venue_id, :scope => :assignment_id, :message => "already checked in"
  
  after_create :generate_trophy
  
  def generate_trophy
    if !trophy_awarded && assignment.hop.venues.count==assignment.checkins.count
      Trophy.create(:hop_id => assignment.hop_id, :user_id => assignment.user_id)
    end
  end
  
  def trophy_awarded
    Trophy.exists?(:hop_id => assignment.hop_id, :user_id => assignment.user_id)
  end
  
end
