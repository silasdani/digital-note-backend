# frozen_string_literal: true

class CreateStudyLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :study_levels do |t|
      t.string :name
      t.timestamps
    end
  end
end
