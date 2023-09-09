require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'My Post', text: 'This is my post content') }

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'comments_counter must be an integer greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter must be an integer greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'author_id must be an integer greater than or equal to 0' do
    subject.author_id = -1
    expect(subject).to_not be_valid
  end
end
