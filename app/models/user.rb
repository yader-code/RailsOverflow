class User < ApplicationRecord
  validates :name, presence: true
  validates :keywords, presence: true

  validates_length_of :name, minimum: 3

  before_save :upcase_first_letters
  before_save :remove_white_spaces_begin_and_end_of_name

  private

  def upcase_first_letters
    full_name = name.split
    self.name = ''
    full_name.each { |word| self.name += "#{word.capitalize} " }
  end

  def remove_white_spaces_begin_and_end_of_name
    self.name.strip!
  end

end
