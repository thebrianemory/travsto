require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  before(:each) do
  end
  login_user

  describe 'GET #index' do
    it 'populates an array of all businesses'
    it 'renders the :index template'
  end

  describe 'GET #show' do
    it 'assigns the requested business to @business'
    it 'renders the :show template'
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
      before(:each) do
      end
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
      it "locates the requested @business"
      it "changes @business' attributes"
      it "redirectes to the updated business"
    end

    context 'with invalid attributes' do
      it "does not change the business' attributes"
      it 're-renders the :edit template'
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the business'
    it 'redirects to businesses#index'
  end
end
