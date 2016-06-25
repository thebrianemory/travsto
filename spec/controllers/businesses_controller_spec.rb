require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  before(:each) do
    @category = create(:category)
    @business = create(:business, category_id: @category.id)
  end
  login_user

  # describe 'Users access' do
  #   it 'allows the user to view the business index' do
  #     get :index
  #     expect(response).to render_template :index
  #   end
  #   it 'allows the user to view a business page' do
  #     get :show, id: @business
  #     expect(response).to render_template :show
  #   end
  #   it 'redirects to sign in page if not signed in' do
  #     sign_out :user
  #     get :show, id: @business
  #     expect(response).to redirect_to new_user_session_path
  #   end
  # end

  describe 'GET #index' do
    it 'populates an array of all businesses'
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns the requested business to @business'
    it 'renders the :show template' do
      get :show, id: @business
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new business to @business'
    it 'renders the :new template'
  end

  describe 'GET #edit' do
    it 'assigns the requested business to @business'
    it 'renders the :edit template'
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new business in the database'
      it 'redirects to business#show'
    end

    context 'with invalid attributes' do
      it 'does not save the new business in the database'
      it 're-renders the :new template'
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the business in the database'
      it 'redirects to the business'
    end

    context 'with invalid attributes' do
      it 'does not update the business'
      it 're-renders the :edit template'
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the business from the database'
    it 'redirects to businesses#index'
  end
end
