require 'rails_helper'

# test content of home page
RSpec.describe 'User', type: :system, js: true do
  before(:each) do
    # Create a user with the specified attributes
    User.create(id: 1, name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                bio: 'Teacher from Mexico.', post_count: 1)
    User.create(id: 2, name: 'Daniel Ochuba', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                bio: 'Teacher from Mexico.', post_count: 3)
  end

  describe 'index page' do
    it 'shows the right content' do
      visit user_path(1) # Visit the user with ID 1
      expect(page).to have_content('Tom')
    end

    it 'it should display username' do
      visit user_path(1)
      expect(page).to have_content('Tom')
    end

    it 'it should display username' do
      visit user_path(2)
      expect(page).to have_content('Daniel')
    end

    it 'shows the username of all other users.' do
      visit root_path # Visit the user with ID 1
      expect(page).to have_content('Tom')
      expect(page).to have_content('Daniel')
    end

    # I can see the number of posts each user has written.
    it 'showthe number of posts each user has written.' do
      visit root_path
      expect(page).to have_content('Number of posts: 1')
      expect(page).to have_content('Number of posts: 3')
    end

    it 'provides links to user show pages ' do
      visit root_path
      user1 = User.find(1)
      click_link(user1.name)
      expect(page).to have_current_path(user_path(user1))
    end

    it 'shows the profile picture of the user' do
      visit root_path
      expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
      expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
    end
  end
end
