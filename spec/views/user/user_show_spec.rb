require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  include Rails.application.routes.url_helpers
  let!(:user) { User.create(name: 'Menen', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', post_count: 5) }

  let!(:post) do
    Post.create(title: 'test2', text: 'second post', author: user)
  end
  before do
    visit user_path(user)
  end

  it 'show user profile picture' do
    expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end
  it 'show the users username' do
    expect(page).to have_content(user.name)
  end

  it 'showthe number of posts the user has written.' do
    expect(page).to have_content("Number of posts : #{user.post_count}")
  end

  it 'show the bio of the user' do
    expect(page).to have_content(user.bio)
  end

  it 'shows the user first three posts' do
    user.recent_posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  it 'displays the button to see all posts' do
    expect(page).to have_link('Show All')
  end

  it 'redirects to the post index page when see all post link is clicked' do
    click_link('Show All')

    expect(page).to have_current_path(user_posts_path(user))
  end
end
