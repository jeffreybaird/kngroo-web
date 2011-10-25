require 'test_helper'

class CheckinTest < ActiveSupport::TestCase

  should belong_to :assignment
  should belong_to :venue

  should validate_presence_of :assignment_id
  should validate_presence_of :venue_id

end
