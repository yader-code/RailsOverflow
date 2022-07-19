# frozen_string_literal: true

class ChangeKeywordsColumn < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |_user|
      change_column :users, :keywords, :text, array: true, default: [],
                                              using: "(string_to_array(keywords, ','))"
    end
  end
end
