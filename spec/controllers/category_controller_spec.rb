require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "Guest user access" do
    before(:each) do
      @category = create(:category)
    end

    describe 'GET #index' do
      it 'populates an array of all categories' do
        category2 = create(:category)
        get :index
        expect(assigns(:categories)).to match_array([@category, category2])
      end
      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      before(:each) do
        sign_out :user
      end
      it 'assigns the requested category to @category' do
        get :show, id: @category
        expect(assigns(:category)).to eq @category
      end
      it 'renders the :show template' do
        get :show, id: @category
        expect(response).to render_template :show
      end
    end
  end

  describe "Admin user access" do
    before(:each) do
      @category = create(:category)
    end
    login_admin

    describe 'GET #new' do
      it 'redirects a guest' do
        sign_out :user
        get :new
        expect(response).to redirect_to root_url
      end
      it 'redirects a user who is not an admin' do
        sign_out :user
        sign_in user2 = create(:user)
        get :new
        expect(response).to redirect_to root_url
      end
      it 'assigns a new category to @category' do
        get :new
        expect(assigns(:category)).to be_a_new(Category)
      end
      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it 'redirects a guest' do
        sign_out :user
        get :edit, id: @category
        expect(response).to redirect_to root_url
      end
      it 'redirects a user who is not an admin' do
        sign_out :user
        sign_in user2 = create(:user)
        get :edit, id: @category
        expect(response).to redirect_to root_url
      end
      it 'assigns the requested category to @category' do
        get :edit, id: @category
        expect(assigns(:category)).to eq @category
      end
      it 'renders the :edit template' do
        get :edit, id: @category
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'does not allow guests to create a category' do
          sign_out :user
          expect {
            post :create, category: attributes_for(:category)
          }.not_to change(Category, :count)
        end
        it 'it does not allow users to create a category' do
          sign_out :user
          sign_in user2 = create(:user)
          expect {
            post :create, category: attributes_for(:category)
          }.not_to change(Category, :count)
        end
        it 'saves the new category in the database' do
          expect {
            post :create, category: attributes_for(:category)
          }.to change(Category, :count).by(1)
        end
        it 'redirects to category#show' do
          post :create, category: attributes_for(:category)
          expect(response).to redirect_to category_path(assigns[:category])
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new category in the database' do
          expect {
            post :create, category: attributes_for(:invalid_category)
          }.not_to change(Category, :count)
        end
        it 're-renders the :new template' do
          post :create, category: attributes_for(:invalid_category)
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context 'with valid attributes' do
        it "locates the requested @category" do
          patch :update, id: @category, category: attributes_for(:category)
          expect(assigns(:category)).to eq(@category)
        end
        it 'does not allow a guest to update a category' do
          sign_out :user
          patch :update, id: @category, category: attributes_for(:category, name: "Hotel")
          @category.reload
          expect(@category.name).not_to eq("Hotel")
        end
        it 'does not allow a user to update a category' do
          sign_out :user
          sign_in user2 = create(:user)
          patch :update, id: @category, category: attributes_for(:category, name: "Hotel")
          @category.reload
          expect(@category.name).not_to eq("Hotel")
        end
        it "changes @category' attributes" do
          patch :update, id: @category, category: attributes_for(:category, name: "Hotel")
          @category.reload
          expect(@category.name).to eq("Hotel")
        end
        it "redirectes to the updated category" do
          patch :update, id: @category, category: attributes_for(:category)
          expect(response).to redirect_to @category
        end
      end

      context 'with invalid attributes' do
        it "does not change the category' attributes" do
          cat_name = @category.name
          patch :update, id: @category, category: attributes_for(:invalid_category)
          @category.reload
          expect(@category.name).to eq(cat_name)
        end
        it 're-renders the :edit template' do
          patch :update, id: @category, category: attributes_for(:invalid_category)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'does not allow a guest to delete a category' do
        sign_out :user
        expect {
          delete :destroy, id: @category
        }.not_to change(Category, :count)
      end
      it 'does not allow a user to delete a category' do
        sign_out :user
        sign_in user2 = create(:user)
        expect {
          delete :destroy, id: @category
        }.not_to change(Category, :count)
      end
      it 'deletes the category' do
        expect {
          delete :destroy, id: @category
        }.to change(Category, :count).by(-1)
      end
      it 'redirects to categories#index' do
        delete :destroy, id: @category
        expect(response).to redirect_to categories_path
      end
    end
  end
end
