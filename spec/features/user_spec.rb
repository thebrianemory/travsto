require 'rails_helper'

feature 'User expectations' do
  before(:each) do
    sign_in create(:user)
    visit root_path
  end
  scenario 'a user can view the business index', js: false do
    click_link 'Businesses'
    within 'h1' do
      expect(page).to have_content 'Business Index'
    end
  end

  scenario 'a user can view the trips index', js: false do
    click_link 'Trips'
    within 'h1' do
      expect(page).to have_content 'Trip Index'
    end
  end

  scenario 'a user can log out' do
    click_link 'Account'
    click_link 'Log Out'
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'a user can visit their profile page' do
    click_link 'Account'
    click_link 'Profile'
    expect(page).to have_content "Welcome, #{User.last.username}!"
  end

  scenario 'a user can view the new trip page' do
    
  end
end
