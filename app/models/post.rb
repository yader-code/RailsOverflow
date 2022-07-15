# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments
  belongs_to :user
  has_many :posts
  belongs_to :post, optional: true

  validates_presence_of :content

  def as_json(_options = {})
    super(except: %i[user_id updated_at])
  end

  def self.posts_parents
    where(post_id: nil)
  end
end
