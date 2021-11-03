class CreateStudyLevelsUsersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :study_levels, :users do |t|
      t.index [:study_level_id, :user_id], unique: true
    end
  end
end
