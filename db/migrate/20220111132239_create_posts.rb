class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :type
      t.string :message
      t.string :attachment_links
      t.integer :likes

      t.timestamps
    end
  end
end
