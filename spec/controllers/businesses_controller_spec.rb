require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  before(:each) do
    @business = create(:business)
    @category = Category.find_by_id(@business.category_id)
  end
  login_admin

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

  describe 'GET #new' do
    it 'assigns a new business to @business' do
      get :new
      expect(assigns(:business)).to be_a_new(Business)
    end
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested business to @business' do
      get :edit, id: @business
      expect(assigns(:business)).to eq @business
    end
    it 'renders the :edit template' do
      get :edit, id: @business
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before(:each) do
        @category = create(:category)
      end
      it 'saves the new business in the database' do
        expect {
          post :create, business: attributes_for(:business, category_id: @category.id)
        }.to change(Business, :count).by(1)
      end
      it 'redirects to business#show' do
        post :create, business: attributes_for(:business, category_id: @category.id)
        expect(response).to redirect_to business_path(assigns[:business])
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new business in the database' do
        expect {
          post :create, business: attributes_for(:business)
        }.not_to change(Business, :count)
      end
      it 're-renders the :new template' do
        post :create, business: attributes_for(:business)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
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

    context 'with invalid attributes' do
      it "does not change the business' attributes" do
        biz_name = @business.name
        patch :update, id: @business, business: attributes_for(:business, name: nil)
        @business.reload
        expect(@business.name).to eq(biz_name)
      end
      it 're-renders the :edit template' do
        patch :update, id: @business, business: attributes_for(:invalid_business)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
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
