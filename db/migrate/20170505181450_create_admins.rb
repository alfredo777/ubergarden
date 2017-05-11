class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.string :token
      t.string :password
      t.string :salt

      t.timestamps
    end
  end
end
