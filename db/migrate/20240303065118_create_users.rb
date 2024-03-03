class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :mobile
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    add_index :users, :mobile, unique: true
  end
end
