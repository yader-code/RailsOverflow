class AddUserIndex < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :verified, :boolean
    add_column :users, :verification_date, :datetime
    add_index(:users, :auth_token, unique: true)
  end
end
