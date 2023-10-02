require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.feature 'User Post Index Page' do
  let!(:user) { User.create(name: 'test_user', bio: 'this is bio', photo: 'user1.jpg') }
  let!(:user_comment) { User.create(name: 'John', bio: 'this is bio', photo: 'John.jpg') }
  let!(:post1) { Post.create(author: user, title: 'Post 1', text: 'this is body of a post') }
  let!(:post2) { Post.create(author: user, title: 'Post 2', text: 'Body 2') }
  let!(:comment1) { Comment.create(post: post1, text: 'Comment 1', user: user_comment) }
  let!(:comment2) { Comment.create(post: post1, text: 'Comment 2', user: user_comment) }
  let!(:comment3) { Comment.create(post: post1, text: 'Comment 3', user: user_comment) }
  let!(:comment4) { Comment.create(post: post1, text: 'Comment 4', user: user_comment) }
  let!(:comment5) { Comment.create(post: post1, text: 'Comment 5', user: user_comment) }
  let!(:comment6) { Comment.create(post: post1, text: 'Comment 6', user: user_comment) }

  scenario 'Displays user profile information' do
    visit user_posts_path(user)

    expect(page).to have_css("img[src*='#{user.photo}']")

    # Verify that the user's username is displayed
    expect(page).to have_content(user.name)

    # Verify that the number of posts the user has written is displayed
    expect(page).to have_content("Number of post : #{user.post_counter}")

    # Verify that the user's bio is displayed
    expect(page).to have_content(user.bio)
  end

  scenario 'Display right total comment and like' do
    visit user_posts_path(user)

    expect(page).to have_content("Comments : #{post1.comment_counter}, Likes : #{post1.like_counter}")
  end

  scenario 'Displays only 5 rencent comments' do
    visit user_posts_path(user)

    expect(page).to have_content('Comment 6')
    expect(page).to have_content('Comment 5')
    expect(page).to have_content('Comment 4')
    expect(page).to have_content('Comment 3')
    expect(page).to have_content('Comment 2')

    # not showing the first comment
    expect(page).to_not have_content('Comment 1')
  end

  scenario 'Displays part of the body' do
    visit user_posts_path(user)

    expect(page).to have_content('this is body of a post')
  end
  
  scenario 'Displays title of the post correctly' do
    visit user_posts_path(user)

    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
  end

  scenario 'Redirects to the post show page when a post is clicked' do
    visit user_posts_path(user)

    # Click on a post
    click_link 'Post 1'

    # Verify that the page redirects to the post's show page
    expect(current_path).to eq(user_post_path(user_id: post1.author_id, id: post1.id))
  end
end
# rubocop:enable Metrics/BlockLength
