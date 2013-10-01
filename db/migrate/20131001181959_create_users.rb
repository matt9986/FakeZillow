class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :pass_hash
      t.boolean :agent
      t.string :session_token

      t.timestamps
    end
    add_index :users, :email, {unique: true}
    add_index :users, :session_token, {unique: true}
  end
end
