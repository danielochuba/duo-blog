require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  describe 'show page' do
    let!(:user) do
      User.create(name: 'Alex', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Chemist', post_count: 3)
    end
    let!(:post) do
      Post.create(title: 'test1', text: 'first post', author: user)
    end
    let!(:post2) do
      Post.create(title: 'test2', text: 'second post', author: user)
    end
    let!(:post3) do
      Post.create(title: 'test3', text: 'third post', author: user)
    end

    before do
      visit user_path(user)
    end
    it 'displays the button to see all posts' do
      expect(page).to have_link('Show All')
    end

    it 'redirects to the post index page when see all post link is clicked' do
      click_link('Show All')

      expect(page).to have_current_path(user_posts_path(user))
    end
  end
end
