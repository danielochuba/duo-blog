require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) do
    User.create!(
      id: 1,
      name: 'John Doe',
      photo: 'john@example.com',
      bio: 'Nigga',
      post_count: 0
    )
  end
  let(:valid_attributes) do
    {
      title: 'Big programmer',
      text: 'Daniel Ochuba would do great things',
      comments_counter: 0,
      likes_counter: 0,
      author_id: user.id
    }
  end

  it 'renders a successful response' do
    post = Post.create!(valid_attributes)
    get user_posts_path(post)
    expect(response).to be_successful
  end

  it 'renders the correct template' do
    post = Post.create!(valid_attributes)
    get user_posts_path(post)
    expect(response).to render_template('posts/index')
  end

  it 'includes correct placeholder text in the response body' do
    post = Post.create!(valid_attributes)
    get user_posts_path(post)
    expect(response.body).to include('Number of comments on each post')
  end
end
