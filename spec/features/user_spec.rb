require 'rails_helper'

feature 'User management' do
  scenario "a visitor can create an account", js: false do
    visit root_path
    expect{
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
    within 'h1' do
      expect(page).to have_content 'User Profile Page'
    end
    expect(page).to have_content 'batman'
  end

  scenario 'a vistor can log into their account' do
    sign_in user = create(:user)
  end
end