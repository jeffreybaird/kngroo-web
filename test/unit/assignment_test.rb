require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase

  should belong_to :user
  should belong_to :hop
  should have_many :checkins
  
  should validate_presence_of :user_id
  should validate_presence_of :hop_id

end
