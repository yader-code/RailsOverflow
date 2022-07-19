# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password :password, validations: false
  has_secure_token :auth_token, length: 36

  has_many :posts
  has_many :comments

  validates :name, presence: true
  validates :keywords, presence: true
  validates :email, presence: true, uniqueness: true

  validates_length_of :name, minimum: 3
  validates_length_of :password, minimum: 6, if: :password_digest_changed?

  before_save :upcase_first_letters
  before_save :remove_white_spaces_begin_and_end_of_name

  private

  def upcase_first_letters
    self.name = name.split.each(&:capitalize!).join(' ')
  end

  def remove_white_spaces_begin_and_end_of_name
    name.strip!
  end
end
