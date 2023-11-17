require 'rails_helper'
RSpec.feature 'User post show page', type: :feature do
  before do
    @user = User.find_by(name: 'Tom')
    @post = @user.posts.first
  end
  scenario 'I can see the posts title.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.title)
  end
  scenario 'I can see who wrote the post.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@user.name)
  end
  scenario 'I can see how many comments it has.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.comments_counter)
  end
  scenario 'I can see how many likes it has.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.likes_counter)
  end
  scenario 'I can see the username of each commentor.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.comments.first.user.name) if @post.comments.first.user
  end
  scenario 'I can see the comment each commentor left.' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.comments.first.text)
  end
end
