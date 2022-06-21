require 'rails_helper'

RSpec.describe User, type: :model do
  it 'correctly created' do
    user = User.new(name: 'Jhader', keywords: ['Testing'])
    expect(user).to be_valid
  end

  it 'when no name presence' do
    user = User.new(name: nil, keywords: ['Testing'])
    expect(user).to_not be_valid
  end

  it 'when no keywords presence' do
    user = User.new(name: 'Jhader', keywords: nil)
    expect(user).to_not be_valid
  end

  it 'when name length under 3 character' do
    user = User.new(name: 'Pi', keywords: ['Testing'])
    expect(user).to_not be_valid
  end
end
