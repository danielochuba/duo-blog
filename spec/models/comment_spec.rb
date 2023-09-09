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
end
