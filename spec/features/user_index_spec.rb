require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  before do
    @users = User.all
  end
  scenario 'I can see the username of all other users' do
    visit users_path
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path

    # Verify that the profile pictures are displayed on the users index page
    expect(page).to have_css('.img-user-container img', count: User.count)
  end

  scenario 'I can see the number of posts each user has written' do
    visit users_path

    # Verify that the number of posts for each user is displayed on the users index page
    @users.each do |user|
      expect(page).to have_content("Number of posts: #{user.post_counter}")
    end
  end

  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    visit users_path

    # Click on the link for the first user
    click_link @users.first.name

    # Verify that it redirects to the user's show page correctly
    expect(page).to have_current_path(user_path(@users.first))
  end
end
