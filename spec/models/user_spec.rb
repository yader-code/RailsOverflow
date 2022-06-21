require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when User correctly created' do
    user = User.new(name: 'Jhader', keywords: ['Testing'])
    it { expect(user).to be_valid }
  end

  context 'when no name presence' do
    user = User.new(name: nil, keywords: ['Testing'])
    it  { expect(user).to_not be_valid }
  end

  context 'when no keywords presence' do
    user = User.new(name: 'Jhader', keywords: nil)
    it { expect(user).to_not be_valid }
  end

  context 'when name length under 3 characters' do
    user = User.new(name: 'Pi', keywords: ['Testing'])
    it { expect(user).to_not be_valid }
  end
end
