require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_attributes) do
    {
      id: 1,
      name: 'John Doe',
      photo: 'john@example.com',
      bio: 'Nigga',
      post_count: 0
    }
  end

  it 'renders a successful response' do
    user = User.create!(valid_attributes)
    get user_url(user)
    expect(response).to be_successful
  end

  it 'renders the correct template' do
    user = User.create!(valid_attributes)
    get user_url(user)
    expect(response).to render_template('users/show')
  end

  it 'includes correct placeholder text in the response body' do
    user = User.create!(valid_attributes)
    get user_url(user)

    expect(response.body).to include("This page shows a Selected user's profile")
  end

  it 'includes correct placeholder text in the response body' do
    user = User.create!(valid_attributes)
    get user_url(user)
    expect(response.body).to include("User's Name")
    expect(response.body).to include('button to see all post')
  end

  it 'includes correct placeholder text in the response body' do
    user = User.create!(valid_attributes)
    get user_url(user)
    expect(response.body).to include('Number of comments')
  end
end
