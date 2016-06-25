require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  before(:each) do
    @category = create(:category)
    @business = create(:business, category_id: @category.id)
  end
  login_user

  describe 'GET #index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'Users access' do
    it 'allows the user to view the business index' do
      get :index
      expect(response).to render_template :index
    end
    it 'allows the user to view a business page' do
      get :show, id: @business
      expect(response).to render_template :show
    end
    it 'redirects to sign in page if not signed in' do
      sign_out :user
      get :show, id: @business
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET #show' do

  end

  describe 'GET #new' do

  end

  describe 'GET #edit' do

  end

  describe 'POST #create' do

  end

  describe 'PATCH #update' do

  end

  describe 'DELETE #destroy' do

  end
end
