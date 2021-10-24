class CreateStudyLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :study_levels do |t|
      t.string :name
      t.timestamps
    end
  end
end
