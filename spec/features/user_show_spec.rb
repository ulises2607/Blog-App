require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  before do
    # It's not necessary to create users and posts here, as they are already in the test database
    @user = User.find_by(name: 'Tom')
  end

  scenario 'I can see the user\'s profile picture' do
    visit user_path(@user)

    # Verify that the user's profile picture is displayed
    expect(page).to have_css('.img-user-container img')
  end

  scenario 'I can see the user\'s username' do
    visit user_path(@user)

    # Verify that the user's username is displayed
    expect(page).to have_content(@user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    visit user_path(@user)

    # Verify that the number of posts by the user is displayed
    expect(page).to have_content("Number of posts: 25") # Adjust the number based on your specific data
  end

  scenario 'I can see the user\'s bio' do
    visit user_path(@user)

    # Verify that the user's bio is displayed
    expect(page).to have_css('.bio-container p', text: 'Brasilian student')
  end

  scenario 'I can see the user\'s first 3 posts' do
    visit user_path(@user)

    # Verify that the first 3 posts of the user are displayed
    @user.posts.limit(3).each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  scenario 'I can see a button that lets me view all of a user\'s posts' do
    visit user_path(@user)

    # Verify that a button to view all of the user's posts is displayed
    expect(page).to have_button('See all posts')
  end

  scenario 'When I click a user\'s post, it redirects me to that post\'s show page' do
    visit user_path(@user)
  
    # Click on the first user post
    first('.post-item a').click

    # Verify that it redirects to the post's show page correctly
    expect(page.current_path).to include("/users/1/posts/1")
  end

  scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    visit user_path(@user)
  
    # Click on the button to see all of the user's posts
    click_link 'See all posts'
  
    # Verify that it redirects to the user's post index page correctly
    expect(page).to have_current_path("/users/1/posts")
  end
end
