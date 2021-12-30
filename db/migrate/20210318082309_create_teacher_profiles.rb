# frozen_string_literal: true

class CreateTeacherProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_profiles do |t|
      t.string :education
      t.integer :exp_years
      t.decimal :price, precision: 5, scale: 2
      t.integer :meeting_duration_in_minutes
      t.string :desc
      t.date :date_of_birth
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :teacher_profiles, %i[user_id created_at]
  end
end
