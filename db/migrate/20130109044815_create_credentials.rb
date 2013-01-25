class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.string :token
      t.string :auth_user
      t.string :auth_password

      t.timestamps
    end
  end
end
