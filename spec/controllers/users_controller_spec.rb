require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @user = create(:user)
  end
  describe "GET #show" do
    it 'assigns the requested user to @user' do
      get :show, id: @user
      expect(assigns(:user)).to render_template :show
    end
    it 'renders the :show template' do
      get :show, id: @user
      expect(response).to render_template :show
    end
  end

  describe 'has a current user' do
    login_user
    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end
  end

  describe 'GET #trips' do
    it 'allows the user to view their trips' do
      get :trips, username: @user
      expect(response).to render_template :trips
    end
  end

  describe 'GET #reviews' do
    it 'allows the user to view their reviews' do
      get :reviews, username: @user
      expect(response).to render_template :reviews
    end
  end
end
