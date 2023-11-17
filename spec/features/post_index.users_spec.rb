require 'rails_helper'

RSpec.feature 'Post index, users features', type: :feature do
  before do
    @user = User.find_by(name: 'Tom')
  end

  scenario 'I can see the users profile picture.' do
    visit user_posts_path(@user)
    expect(page).to have_css('.img-user-container img')
  end

  scenario 'I can see the users username.' do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.name)
  end

  scenario 'I can see the number of posts the user has written.' do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.post_counter)
  end

  scenario 'I can see a posts title.' do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.posts.first.title)
  end

  scenario 'I can see the first comments on a post.' do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.posts.first.comments.first.text)
  end
end
