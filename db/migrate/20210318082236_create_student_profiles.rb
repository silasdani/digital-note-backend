# frozen_string_literal: true

class CreateStudentProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :student_profiles do |t|
      t.string :school
      t.date :date_of_birth
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :student_profiles, %i[user_id created_at]
  end
end
