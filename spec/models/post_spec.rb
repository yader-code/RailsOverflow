require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'correctly created' do
    post = Post.new(user: User.new, content: 'Test')
    expect(post).to be_valid
  end

  it 'when no user presence' do
    post = Post.new(user: nil, content: 'Test')
    expect(post).to_not be_valid
  end

  it 'when no content presence' do
    post = Post.new(user: User.new, content: nil)
    expect(post).to_not be_valid
  end
end
