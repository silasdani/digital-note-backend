class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    
    create_table :subjects do |t|
      t.string :title
      t.string :desc
      t.string :category
      t.timestamps
    end

  end
end
