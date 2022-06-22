require 'rails_helper'

describe Post, type: :model do

  let(:post) { Post.new(user: User.new, content: 'Test') }

  context 'when Post correctly created' do
    it { expect(post).to be_valid }
  end

  context 'when no user presence' do
    it 'without user is an invalid object' do
      post.user = nil
      expect(post).to_not be_valid
    end
  end

  context 'when no content presence' do
    it 'without content is an invalid object' do
      post.user = nil
      expect(post).to_not be_valid
    end
  end
end
