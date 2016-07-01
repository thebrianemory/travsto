require 'rails_helper'

feature 'Visitor expectations' do
  scenario 'a visitor can view the business index', js: false do
    visit root_path
    click_link 'Businesses'
    click_link 'View All Businesses'
    within 'h1' do
      expect(page).to have_content 'Business Index'
    end
  end
  scenario 'a visitor can view businesses by category', js: false do
    create(:category, name: 'Restaurants')
    visit root_path
    click_link 'Businesses'
    click_link 'View Restaurants'
    within 'h1' do
      expect(page).to have_content 'Restaurants Index'
    end
  end
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
feature 'User management' do

end
