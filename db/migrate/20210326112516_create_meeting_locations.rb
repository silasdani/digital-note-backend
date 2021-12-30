# frozen_string_literal: true

class CreateMeetingLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :meeting_locations do |t|
      t.string :name
      t.timestamps
    end
  end
end
