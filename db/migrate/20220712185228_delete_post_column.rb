# frozen_string_literal: true

class DeletePostColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :string
  end
end
