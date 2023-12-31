require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  # post_counter must be an integer greater than or equal to 0

  it 'post_counter must be an integer greater than or equal to 0' do
    subject.post_count = -1
    expect(subject).to_not be_valid
  end
end
