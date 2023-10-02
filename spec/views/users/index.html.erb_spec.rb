require 'rails_helper'

RSpec.feature 'User Index Page' do
  # Create some test users and posts
  let!(:user1) { User.create(name: 'user1', photo: 'user1.jpg') }
  let!(:user2) { User.create(name: 'user2', photo: 'user2.jpg') }
  let!(:post1) { Post.create(author: user1) }
  let!(:post2) { Post.create(author: user1) }

  scenario 'Displays user1 usernames, profile pictures, and post counts' do
    visit users_path

    # Verify that usernames are displayed
    expect(page).to have_content(user1.name)

    # Verify that profile pictures are displayed (assuming you have an 'avatar' attribute)
    expect(page).to have_css("img[src*='#{user1.photo}']")

    # Verify that post counts are displayed
    expect(page).to have_content("Number of post : #{user1.post_counter}")
  end

  scenario 'Displays user2 usernames, profile pictures, and post counts' do
    visit users_path

    # Verify that usernames are displayed
    expect(page).to have_content(user2.name)

    # Verify that profile pictures are displayed (assuming you have an 'avatar' attribute)
    expect(page).to have_css("img[src*='#{user2.photo}']")

    # Verify that post counts are displayed
    expect(page).to have_content("Number of post : #{user2.post_counter}")
  end

  scenario 'Redirects to user show page when clicked' do
    visit users_path

    # Click on a user's username
    click_link user1.name

    # Verify that the page redirects to the user's show page
    expect(current_path).to eq(user_path(user1))
  end
end
