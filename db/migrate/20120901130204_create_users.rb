class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.boolean :email_verified, default: false
      t.string :auth_token

      t.timestamps
    end
  end
end
