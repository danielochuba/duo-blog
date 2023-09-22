require 'rails_helper'

RSpec.feature 'Post index page', type: :feature do
  describe 'index page' do
    let!(:user) do
      User.create(name: 'Alex', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Chemist', post_count: 5)
    end

    let!(:lily) do
      User.create(name: 'lily', photo: 'l.jpg', bio: 'teacher from mexico', post_count: 0)
    end

    let!(:post) do
      Post.create(title: 'Post Title', text: 'Post Text', author: user)
    end

    let!(:comment) do
      Comment.create(user: lily, post:, text: 'Great post!')
    end

    before do
      visit user_posts_path(user)
    end
    it ' can see the user profile picture.' do
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
    it 'I can see the user username.' do
      expect(page).to have_content(user.name)
    end
    it 'show the number of posts the user has written.' do
      expect(page).to have_content("Number of posts : #{user.post_count}")
    end

    it 'I can see a post title.' do
      expect(page).to have_content(post.title)
    end
    it 'displays some of the post\'s body' do
      expect(page).to have_selector('p', text: 'Post Text')
    end
    it 'I can see the first comments on a post.' do
      post.recent_comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
    it 'displays how many comments and likes a post has' do
      expect(page).to have_content(/Comments:\s*1\s*,\s*Likes\s*:\s*0/)
    end
    it 'displays a section for pagination' do
      expect(page).to have_selector('a', text: 'Show all posts')
    end
    it 'When I click on a post, it redirects me to that post show page.' do
      click_link(post.title)
      expect(current_path).to eq(user_post_path(user, post))
    end
  end
end
