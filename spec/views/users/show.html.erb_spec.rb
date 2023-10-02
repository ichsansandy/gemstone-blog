require 'rails_helper'

RSpec.feature 'User Show Page' do
  # Create a test user with posts
  let!(:user1) { User.create(name: 'user1', bio: 'this is bio', photo: 'user1.jpg') }
  let!(:post1) { Post.create(author: user1, title: 'Post 1', text: 'This is post 1') }
  let!(:post2) { Post.create(author: user1, title: 'Post 2', text: 'This is post 2') }
  let!(:post3) { Post.create(author: user1, title: 'Post 3', text: 'This is post 3') }
  let!(:post4) { Post.create(author: user1, title: 'Post 4', text: 'This is post 4') }

  scenario 'Displays user profile information' do
    visit user_path(user1)

    expect(page).to have_css("img[src*='#{user1.photo}']")
    expect(page).to have_content(user1.name)
    expect(page).to have_content("Number of post : #{user1.post_counter}")
    expect(page).to have_content(user1.bio)
  end

  scenario 'Displays the first 3 posts' do
    visit user_path(user1)

    # Verify that the titles of the first 3 posts are displayed
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')
    expect(page).to have_content('Post 4')

    # Verify that the content of the first 3 posts is displayed
    expect(page).to have_content('This is post 2')
    expect(page).to have_content('This is post 3')
    expect(page).to have_content('This is post 4')
  end

  scenario 'Redirects to the post show page when a post is clicked' do
    visit user_path(user1)

    # Click on a post
    click_link post2.title

    # Verify that the page redirects to the post's show page
    expect(current_path).to eq(user_post_path(user_id: post2.author_id, id: post2.id))
  end

  scenario 'Redirects to the user\'s post index page when "Load all post" is clicked' do
    visit user_path(user1)

    click_link 'Load all post'

    # Verify that the page redirects to the user's post index page
    expect(current_path).to eq(user_posts_path(user1))
  end
end
