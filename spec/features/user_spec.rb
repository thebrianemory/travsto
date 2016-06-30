require 'rails_helper'

feature 'User management' do
  scenario "adds a new user", js: false do
    # login_as(admin = create(:admin))

    visit root_url
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
end
