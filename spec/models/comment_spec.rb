require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(text: 'My Comment', post_id: 1, user_id: 1) }

  before { subject.save }

  it 'text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'post_id should be present' do
    subject.post_id = nil
    expect(subject).to_not be_valid
  end

  it 'user_id should be present' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  describe '#update_comments_counter' do
    it 'updates the post\'s comments_counter when a comment is saved' do
      user = User.create(name: 'John', post_count: 0)
      post = Post.create(title: 'Test Post', comments_counter: 0, likes_counter: 0, author: user)

      comment = Comment.new(text: 'Test comment', post:, user:)
      expect do
        comment.save
        post.reload
      end.to change(post, :comments_counter).by(1)
    end
  end
end
