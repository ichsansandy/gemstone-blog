require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'User Post Index Page' do
  let!(:user) { User.create(name: 'test_user', bio: 'this is bio', photo: 'user1.jpg') }
  let!(:user_comment) { User.create(name: 'John', bio: 'this is bio', photo: 'John.jpg') }
  let!(:post1) { Post.create(author: user, title: 'This is post title', text: 'This is body for testing post') }
  let!(:comment1) { Comment.create(post: post1, text: 'Comment 1', user: user_comment) }
  let!(:comment2) { Comment.create(post: post1, text: 'Comment 2', user: user_comment) }
  let!(:comment3) { Comment.create(post: post1, text: 'Comment 3', user: user_comment) }
  let!(:comment4) { Comment.create(post: post1, text: 'Comment 4', user: user_comment) }
  let!(:comment5) { Comment.create(post: post1, text: 'Comment 5', user: user_comment) }
  let!(:comment6) { Comment.create(post: post1, text: 'Comment 6', user: user_comment) }

  scenario 'Displays user profile information' do
    visit user_post_path(user_id: post1.author_id, id: post1.id)

    # Verify that the user's username is displayed
    expect(page).to have_content(user.name)
  end

  scenario 'Display right total comment and like' do
    visit user_post_path(user_id: post1.author_id, id: post1.id)

    expect(page).to have_content("Comments : #{post1.comment_counter}, Likes : #{post1.like_counter}")
  end

  scenario 'Displays all comments' do
    visit user_post_path(user_id: post1.author_id, id: post1.id)

    expect(page).to have_content('Comment 6')
    expect(page).to have_content('Comment 5')
    expect(page).to have_content('Comment 4')
    expect(page).to have_content('Comment 3')
    expect(page).to have_content('Comment 2')
    expect(page).to have_content('Comment 1')
  end

  scenario 'Displays post body' do
    visit user_post_path(user_id: post1.author_id, id: post1.id)

    expect(page).to have_content('This is body for testing post')
  end

  scenario 'Displays post title' do
    visit user_post_path(user_id: post1.author_id, id: post1.id)

    expect(page).to have_content('This is post title')
  end
end
# rubocop:enable Metrics/BlockLength
