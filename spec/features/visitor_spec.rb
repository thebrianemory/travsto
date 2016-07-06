require 'rails_helper'

feature 'Visitor expectations' do

  scenario 'a visitor can view the trips index', js: false do
    visit root_path
    click_link 'Travel Stories'
    within 'h1' do
      expect(page).to have_content 'Browse Travel Stories'
    end
  end

  scenario "a visitor can create an account", js: false do
    visit root_path
    expect {
      click_link 'Sign Up'
      fill_in 'First name', with: 'Bat'
      fill_in 'Last name', with: 'Man'
      fill_in 'Email', with: 'batman@example.com'
      fill_in 'Username', with: 'batman'
      find('#password').fill_in 'Password', with: 'Batword1'
      find('#password_confirmation').fill_in 'Password confirmation',
        with: 'Batword1'
      click_button 'Sign Up'
    }.to change(User, :count).by(1)
    expect(current_path).to eq user_path(User.last)
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    within 'h2' do
      expect(page).to have_content "Welcome, #{User.last.username}"
    end
    expect(page).to have_content 'batman'
  end

  scenario 'a vistor can log into their account' do
    user = create(:user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'a visitor can sign in with Facebook' do
    expect {

    }
  end
end
