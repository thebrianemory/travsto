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

  scenario 'a user can view their trips page' do
    click_link 'Account'
    click_link 'My Trips'
    expect(page).to have_content "#{User.last.username}'s trips"
  end

  scenario 'a user can view the new trip page' do
    click_link 'Account'
    click_link 'Add Trip'
    expect(page).to have_content "Create a new trip"
  end

  scenario 'a user can create a new trip' do
    create(:business)
    expect {
      click_link 'Account'
      click_link 'Add Trip'
      fill_in 'Title', with: 'This is my trip to Hawaii'
      fill_in 'Description', with: 'I need...I need...I need... fish fingers and custard! I never know why. I only know who. Come along, Pond! There are fixed points throughout time where things must stay exactly the way they are. This is not one of them. This is an opportunity!'
      click_button 'Add Trip'
    }.to change(Trip, :count).by(1)
  end
end
