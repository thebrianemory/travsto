require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    login_user
    it 'allows a user to view their profile page' do
      get :show, id: login_user
      expect(response).to render_template :show
    end

    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end
  end
end
