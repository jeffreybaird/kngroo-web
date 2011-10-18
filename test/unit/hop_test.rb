require 'test_helper'

class HopTest < ActiveSupport::TestCase

  should belong_to :category
  should validate_presence_of :title
  should validate_presence_of :description
  should validate_presence_of :points
  should validate_numericality_of :points
  
end
