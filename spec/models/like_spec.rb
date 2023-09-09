require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { Like.new(user_id: 1, post_id: 1) }

  before { subject.save }

  it 'user_id should be present' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it 'post_id should be present' do
    subject.post_id = nil
    expect(subject).to_not be_valid
  end

  describe '#increment_like_counter' do
    it 'increments the post\'s likes_counter when a like is created' do
      user = User.create(name: 'John', post_count: 0)
      post = Post.create(title: 'Test Post', comments_counter: 0, likes_counter: 0, author: user)

      like = Like.new(post:, user:)
      like.save # Save the like, which should trigger the private method

      post.reload

      expect(post.likes_counter).to eq(1)
    end
  end
end
