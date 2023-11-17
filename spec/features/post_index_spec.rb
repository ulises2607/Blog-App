require 'rails_helper'
RSpec.feature 'Post index page', type: :feature do
  before do
    @user = User.find_by(name: 'Tom')
  end

  scenario 'I can see how many comments a post has.' do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.posts.first.comments_counter)
  end

  scenario 'I can see how many likes a post has.' do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.posts.first.likes_counter)
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view.' do
    visit user_posts_path(@user)
    expect(page).to have_css('.pagination')
  end

  scenario 'When I click on a post, I am redirected to that post\'s show page.' do
    visit user_posts_path(@user)
    first('.post-container').click
    expect(page).to have_current_path(user_post_path(@user, @user.posts.first))
  end
end
