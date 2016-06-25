require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    it 'allows a user to view their profile page' do
      user = create(:user)
      get :show, id: user
      expect(response).to render_template :show
    end
  end

  describe 'has a current user' do
    login_user
    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end
  end
end
