class AddCompleteToAssignments < ActiveRecord::Migration

  def self.up
    add_column :assignments, :complete, :boolean
    Assignment.all.each {|a| a.complete = a.hop.venues.count==a.checkins.count;a.save}
  end

  def self.down
    remove_column :assignments, :complete
  end
  
end
