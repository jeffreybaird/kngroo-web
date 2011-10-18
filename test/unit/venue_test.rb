require 'test_helper'

class VenueTest < ActiveSupport::TestCase

  should have_many :memberships
  should have_many :hops
  should have_many :checkins
  should have_many :trivias
  
  should validate_presence_of :name
  
end
