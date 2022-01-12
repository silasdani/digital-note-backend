class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :password_digest, default: '', null: false
      t.string :email, default: '', null: false
      t.string :phone_no
      t.string :address_city
      t.string :address_street
      t.string :address_no
      t.string :address_country
      t.string :address_county
      t.string :profile_pic

      t.string :remember_digest
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email
      t.integer :failed_attempts, default: 0, null: false

      t.string :unlock_token
      t.datetime :locked_at

      t.timestamps
    end
  end
end
