# frozen_string_literal: true

class AddDetailsToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users do
      change_column_null :users, :name, false
      change_column_null :users, :keywords, false
    end
  end
end
