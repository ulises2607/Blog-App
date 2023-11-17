require 'rails_helper'
RSpec.feature 'User index page', type: :feature do
  scenario 'I can see the username of all other users' do
    visit users_path
    # Verify that the usernames are displayed on the users index page
    expect(page).to have_content('Tom')
    expect(page).to have_content('Silvia')
  end
  scenario 'I can see the profile picture for each user' do
    visit users_path
    # Verify that the profile pictures are displayed on the users index page
    expect(page).to have_css('.img-user-container img', count: User.count)
  end
  scenario 'I can see the number of posts each user has written' do
    visit users_path
    # Verify that the number of posts for each user is displayed on the users index page
    expect(page).to have_content('Number of posts: 25') # Adjust the number based on your specific data
    expect(page).to have_content('Number of posts: 8') # Adjust the number based on your specific data
  end
  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    visit users_path
    # Click on the link for the first user
    click_link 'Tom'
    # Verify that it redirects to the user's show page correctly
    expect(page).to have_current_path(user_path(User.find_by(name: 'Tom')))
  end
end
