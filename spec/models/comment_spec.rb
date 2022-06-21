require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'when Comment correctly created' do
    comment = Comment.new(user: User.new, post: Post.new, content: 'Test')
    it { expect(comment).to be_valid }
  end

  context 'when no content presence' do
    comment = Comment.new(user: User.new, post: Post.new, content: nil)
    it { expect(comment).to_not be_valid }
  end

  context 'when no user presence' do
    comment = Comment.new(user: nil, post: Post.new, content: 'Test')
    it { expect(comment).to_not be_valid }
  end

  context 'when no post presence' do
    comment = Comment.new(user: User.new, post: nil, content: 'Test')
    it { expect(comment).to_not be_valid }
  end
end
