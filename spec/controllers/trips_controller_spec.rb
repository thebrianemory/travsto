require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  describe 'GET #index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
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
