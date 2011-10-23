class Checkin < ActiveRecord::Base

  belongs_to :user
  belongs_to :hop
  belongs_to :venue
  
  validates_presence_of :user_id, :hop_id, :venue_id
  validates_uniqueness_of :venue_id, :scope => [ :user_id, :hop_id ], :message => "already checked in"
  
  after_create :generate_trophy
  
  def generate_trophy
    if hop.venues.count==hop.checkins.select {|c| c.user_id==user_id}.count
      @trophy = Trophy.create(:hop_id => hop_id, :user_id => user_id)
    end
  end
  
  def trophy_awarded
    Trophy.exists?(:hop_id => hop_id, :user_id => user_id)
  end
  
end
