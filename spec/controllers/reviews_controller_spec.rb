require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
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
