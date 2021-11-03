class CreateMeetingLocationsUsersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :meeting_locations, :users do |t|
      t.index [:meeting_location_id, :user_id], unique: true, name: 'meeting_location_index'
    end
  end
end
