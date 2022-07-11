require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.new(name: 'Jhader', keywords: ['Testing'], email: 'testing@test.com', password: 'qwerty123') }

  context 'User correctly created' do
    it { expect(user).to be_valid }
  end

  context 'fail when no name presence' do
    it 'without name is an invalid object' do
      user.name = nil
      expect(user).to_not be_valid
    end
  end

  context 'fail when no keywords presence' do
    it 'without keywords is an invalid object' do
      user.keywords = nil
      expect(user).to_not be_valid
    end
  end

  context 'when name length under 3 characters' do
    it 'with less than 3 characters fails' do
      user.name = 'Te'
      expect(user).to_not be_valid
    end
  end

  context 'fail when no email presence' do
    it 'without email is an invalid object' do
      user.email = nil
      expect(user).to_not be_valid
    end
  end
end
