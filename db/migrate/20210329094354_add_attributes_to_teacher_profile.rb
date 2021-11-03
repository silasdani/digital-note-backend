class AddAttributesToTeacherProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :teacher_profiles, :city, :string
    add_column :teacher_profiles, :is_promoted, :boolean, default: false
  end
end
