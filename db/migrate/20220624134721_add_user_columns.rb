class AddUserColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string
    add_column :users, :password, :string
    add_column :users, :password_digest, :string
    add_index(:users, :email, unique: true)
  end
end
