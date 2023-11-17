require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  before do
    @user = User.find_by(name: 'Tom')
  end

  scenario 'I can see the user\'s profile picture' do
    visit user_path(@user)
    expect(page).to have_css('.img-user-container img')
  end

  scenario 'I can see the user\'s username' do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    visit user_path(@user)
    expect(page).to have_content("Number of posts: #{@user[:post_counter]}")
  end

  scenario 'I can see the user\'s bio' do
    visit user_path(@user)
    expect(page).to have_css('.bio-container p', text: @user.bio)
  end

  scenario 'When I click a user\'s post, it redirects me to that post\'s show page' do
    visit user_path(@user)
    first('.post-item a').click
    expect(page).to have_current_path(user_post_path(@user, @user.posts.first))
  end

  scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    visit user_path(@user)
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
