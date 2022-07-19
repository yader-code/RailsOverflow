# frozen_string_literal: true

require 'rails_helper'

describe Comment, type: :model do
  let(:comment) { Comment.new(user: User.new, post: Post.new, content: 'Test') }

  context 'when Comment correctly created' do
    it { expect(comment).to be_valid }
  end

  context 'when no content presence' do
    it 'without content is an invalid object' do
      comment.content = nil
      expect(comment).to_not be_valid
    end
  end

  context 'when no user presence' do
    it 'without user is an invalid object' do
      comment.user = nil
      expect(comment).to_not be_valid
    end
  end

  context 'when no post presence' do
    it 'without post is an invalid object' do
      comment.post = nil
      expect(comment).to_not be_valid
    end
  end
end
