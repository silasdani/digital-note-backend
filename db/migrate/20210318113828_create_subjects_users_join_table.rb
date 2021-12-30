# frozen_string_literal: true

class CreateSubjectsUsersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :subjects, :users do |t|
      t.index %i[subject_id user_id], unique: true
    end
  end
end
