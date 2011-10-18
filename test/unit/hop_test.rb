require 'test_helper'

class HopTest < ActiveSupport::TestCase

  should belong_to :category
  should have_many :memberships
  should have_many :venues
  should have_many :assignments
  should have_many :users
  should have_many :checkins
  should have_many :trivias
  should have_many :trophies
  
  should validate_presence_of :title
  should validate_presence_of :description
  should validate_presence_of :points
  should validate_numericality_of :points
  
end
