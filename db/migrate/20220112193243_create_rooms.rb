class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :acces_token
      t.string :param_id

      t.timestamps
    end
  end
end
