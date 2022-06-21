require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'correctly created' do
    comment = Comment.new(user: User.new, post: Post.new, content: 'Test')
    expect(comment).to be_valid
  end

  it 'when no content presence' do
    comment = Comment.new(user: User.new, post: Post.new, content: nil)
    expect(comment).to_not be_valid
  end

  it 'when no user presence' do
    comment = Comment.new(user: nil, post: Post.new, content: 'Test')
    expect(comment).to_not be_valid
  end

  it 'when no post presence' do
    comment = Comment.new(user: User.new, post: nil, content: 'Test')
    expect(comment).to_not be_valid
  end
end
