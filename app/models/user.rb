class User < ApplicationRecord
  has_many :posts
  has_many :comments

  validates :name, presence: true
  validates :keywords, presence: true

  validates_length_of :name, minimum: 3

  before_save :upcase_first_letters
  before_save :remove_white_spaces_begin_and_end_of_name

  private

  def upcase_first_letters
    self.name = name.split.each(&:capitalize!).join(' ')
  end

  def remove_white_spaces_begin_and_end_of_name
    self.name.strip!
  end

end
