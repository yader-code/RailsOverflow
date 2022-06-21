require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'when Post correctly created' do
    post = Post.new(user: User.new, content: 'Test')
    it { expect(post).to be_valid }
  end

  context 'when no user presence' do
    post = Post.new(user: nil, content: 'Test')
    it { expect(post).to_not be_valid }
  end

  context 'when no content presence' do
    post = Post.new(user: User.new, content: nil)
    it { expect(post).to_not be_valid }
  end
end
