require 'rails_helper'

feature 'User expectations' do
  before(:each) do
    @user = create(:user)
    sign_in @user
    visit root_path
  end

  scenario 'a user can view the trips index', js: false do
    click_link 'Travel Stories'
    within 'h1' do
      expect(page).to have_content 'Browse Travel Stories'
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
    click_link 'My Travel Stories'
    expect(page).to have_content "Travel Stories by #{User.last.username}"
  end

  scenario 'a user can view the new trip page' do
    click_link 'Account'
    click_link 'Add a Travel Story'
    expect(page).to have_content "Create a New Travel Story"
  end

  scenario 'a user can create a new trip with a current business' do
    biz = create(:business)
    expect {
      click_link 'Account'
      click_link 'Add a Travel Story'
      fill_in 'Title', with: 'This is my trip to Hawaii'
      fill_in 'Description', with: 'I need...I need...I need... fish fingers and custard! I never know why. I only know who. Come along, Pond! There are fixed points throughout time where things must stay exactly the way they are. This is not one of them. This is an opportunity!'
      check("#{biz.name}")
      click_button 'Add Travel Story'
    }.to change(Trip, :count).by(1)
  end

  scenario 'a user can create a new trip with a new business' do
    expect {
      click_link 'Account'
      click_link 'Add a Travel Story'
      fill_in 'Title', with: 'This is my trip to Hawaii'
      fill_in 'Description', with: 'I need...I need...I need... fish fingers and custard! I never know why. I only know who. Come along, Pond! There are fixed points throughout time where things must stay exactly the way they are. This is not one of them. This is an opportunity!'
      fill_in 'Name', with: 'Hula Dog'
      click_button 'Add Travel Story'
    }.to change(Trip, :count).by(1)
  end

  scenario 'a user can create a new trip with a current and a new business' do
    expect {
      biz = create(:business)
      click_link 'Account'
      click_link 'Add a Travel Story'
      fill_in 'Title', with: 'This is my trip to Hawaii'
      fill_in 'Description', with: 'I need...I need...I need... fish fingers and custard! I never know why. I only know who. Come along, Pond! There are fixed points throughout time where things must stay exactly the way they are. This is not one of them. This is an opportunity!'
      check("#{biz.name}")
      fill_in 'Name', with: 'Hula Dog'
      click_button 'Add Travel Story'
    }.to change(Trip, :count).by(1)
  end

  scenario "a user can add a comment" do
    trip = create(:trip)
    user = User.find(trip.user_id)
    trip.businesses << create(:business)
    trip.businesses << create(:business)
    visit user_trip_path(user, trip)
    fill_in 'Leave a comment', with: 'This is really cool'
    click_button 'Add comment'
    expect(trip.comments.count).to eq 1
  end
end
