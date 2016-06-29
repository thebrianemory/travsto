require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @user = create(:user)
  end
  login_user

  describe "GET #show" do
    it 'assigns the requested user to @user' do
      get :show, id: subject.current_user
      expect(assigns(:user)).to render_template :show
    end
    it 'renders the :show template' do
      get :show, id: subject.current_user
      expect(response).to render_template :show
    end
    it 'allows only you to see your profile' do
      user2 = subject.current_user
      sign_out :user
      sign_in @user
      get :show, id: user2
      expect(response).to redirect_to root_url
    end

    it 'allows admins to see any profile' do
      user2 = create(:admin)
      get :show, id: subject.current_user
      expect(response).to render_template :show
    end
  end

  describe 'has a current user' do
    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end
  end

  describe 'GET #trips' do
    it 'allows the user to view their trips' do
      get :my_trips, username: @user
      expect(response).to render_template :my_trips
    end
  end

  describe 'GET #reviews' do
    it 'allows the user to view their reviews' do
      get :my_reviews, username: @user
      expect(response).to render_template :my_reviews
    end
  end
end
