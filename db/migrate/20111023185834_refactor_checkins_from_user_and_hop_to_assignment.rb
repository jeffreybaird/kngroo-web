class RefactorCheckinsFromUserAndHopToAssignment < ActiveRecord::Migration

  def self.up
    add_column :checkins, :assignment_id, :integer
    Checkin.all.each do |checkin|
      checkin.assignment_id = Assignment.find_by_user_id_and_hop_id(checkin.user_id,checkin.hop_id).id
      checkin.save
    end
    remove_column :checkins, :hop_id
    remove_column :checkins, :user_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
  
end
