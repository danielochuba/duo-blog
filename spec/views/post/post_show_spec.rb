require 'rails_helper'

RSpec.feature 'Post show page', type: :feature do
  let!(:user) { User.create(name: 'Menen', photo: 'men.jpg', post_count: 3) }
  let!(:post) do
    user.authored_posts.create(
      author: user,
      title: 'Test Post',
      text: 'Hello'
    )
  end
  let!(:lily) do
    User.create(name: 'lily', photo: 'l.jpg', bio: 'teacher from mexico', post_count: 0)
  end
  let!(:comment1) do
    Comment.create(user: lily, post:, text: 'First post!')
  end
  let!(:comment2) do
    Comment.create(user: lily, post:, text: 'Second post!')
  end
  let!(:comment3) do
    Comment.create(user: lily, post:, text: 'Third post!')
  end

  before do
    visit user_post_path(user, post)
  end

  it 'I can see the post title.' do
    expect(page).to have_content(post.title)
  end
  it 'I can see who wrote the post.' do
    expect(page).to have_content(user.name)
  end
  it 'displays how many comments and likes a post has' do
    expect(page).to have_content(/Comments:\s*3\s*,\s*Likes\s*:\s*0/)
  end
  it 'displays some of the post body' do
    expect(page).to have_selector('p', text: 'Hello')
  end
  it 'I can see the username of each commentator' do
    expect(page).to have_content(comment1.user.name)
    expect(page).to have_content(comment2.user.name)
    expect(page).to have_content(comment3.user.name)
  end
  it 'I can see the comment each commentor left.' do
    expect(page).to have_content(comment1.text)
    expect(page).to have_content(comment2.text)
    expect(page).to have_content(comment3.text)
  end
end
