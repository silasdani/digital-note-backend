class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :credits
      t.string :icon
      t.string :access_token
      t.string :join_token
      t.integer :max_users

      t.timestamps
    end
  end
end
