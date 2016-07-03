require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  before(:each) do
    @business = create(:business)
  end

  describe 'guest and user access rights' do
    describe 'GET #index' do
      it 'populates an array of all businesses' do
        business2 = create(:business)
        get :index
        expect(assigns(:businesses)).to match_array([@business, business2])
      end
      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      it 'assigns the requested business to @business' do
        get :show, id: @business
        expect(assigns(:business)).to eq @business
      end
      it 'renders the :show template' do
        get :show, id: @business
        expect(response).to render_template :show
      end
    end
  end

  describe 'admin access rights' do
    login_admin

    describe 'GET #new' do
      it 'does not allow guests to visit the new business page' do
        sign_out :user
        get :new
        expect(response).to redirect_to root_url
      end
      it 'does not allow users to visit the new business page' do
        sign_out :user
        sign_in user2 = create(:user)
        get :new
        expect(response).to redirect_to root_url
      end
    end

    describe 'GET #edit' do
      it 'does not allow guests to edit a business' do
        sign_out :user
        get :edit, id: @business
        expect(response).to redirect_to root_url
      end
      it 'does not allow users to edit a business' do
        sign_out :user
        sign_in user2 = create(:user)
        get :edit, id: @business
        expect(response).to redirect_to root_url
      end
      it 'assigns the requested business to @business' do
        get :edit, id: @business
        expect(assigns(:business)).to eq @business
      end
      it 'renders the :edit template' do
        get :edit, id: @business
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      context 'with valid attributes' do
        it 'does not allow a guest to update a business' do
          sign_out :user
          patch :update, id: @business, business: attributes_for(:business, name: "This is a new business")
          @business.reload
          expect(@business.name).not_to eq('This is a new business')
        end
        it 'does not allow a user to update a business' do
          sign_out :user
          sign_in user2 = create(:user)
          patch :update, id: @business, business: attributes_for(:business, name: "This is a new business")
          @business.reload
          expect(@business.name).not_to eq('This is a new business')
        end
        it "locates the requested @business" do
          patch :update, id: @business, business: attributes_for(:business)
          expect(assigns(:business)).to eq(@business)
        end
        it "changes @business' attributes" do
          patch :update, id: @business, business: attributes_for(:business, name: "This is a new business")
          @business.reload
          expect(@business.name).to eq('This is a new business')
        end
        it "redirectes to the updated business" do
          patch :update, id: @business, business: attributes_for(:business)
          expect(response).to redirect_to @business
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'does not allow a guest to delete a business' do
        sign_out :user
        expect {
          delete :destroy, id: @business
        }.not_to change(Business, :count)
      end
      it 'does not allow a user to delete a business' do
        sign_out :user
        sign_in user2 = create(:user)
        expect {
          delete :destroy, id: @business
        }.not_to change(Business, :count)
      end
      it 'deletes the business' do
        expect {
          delete :destroy, id: @business
        }.to change(Business, :count).by(-1)
      end
      it 'redirects to businesses#index' do
        delete :destroy, id: @business
        expect(response).to redirect_to businesses_path
      end
    end
  end
end
