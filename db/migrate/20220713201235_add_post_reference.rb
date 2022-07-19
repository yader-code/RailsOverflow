# frozen_string_literal: true

class AddPostReference < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :post, null: true, foreign_key: true
  end
end
