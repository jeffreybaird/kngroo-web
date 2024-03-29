class Checkin < ActiveRecord::Base

  belongs_to :assignment
  belongs_to :venue
  
  validates_presence_of :assignment_id, :venue_id
  validates_uniqueness_of :venue_id, :scope => :assignment_id, :message => "already checked in"
  
  after_create :assign_points
  after_create :generate_trophy
  
  def assign_points
    if assignment.hop.venues.count==assignment.checkins.count
      assignment.user.points += 10
      assignment.user.points += assignment.hop.points
      assignment.user.save
      
      assignment.complete = true
      assignment.save
    else
      assignment.user.points += 10
      assignment.user.save
    end
  end
  
  def generate_trophy
    if assignment.complete && trophy_date==nil
      Trophy.create(:hop_id => assignment.hop_id, :user_id => assignment.user_id)
    end
  end
  
  def trophy_awarded
    (award_date=trophy_date)!=nil && award_date > assignment.created_at
  end
  
  def trophy_date
    Trophy.where(:hop_id => assignment.hop_id, :user_id => assignment.user_id).first.created_at
  rescue 
    nil
  end
  
end
