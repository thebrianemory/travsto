require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  before(:each) do
    @review = create(:review)
    @business = Business.find_by_id(@review.business_id)
    @user = User.find_by_id(@review.user_id)
    sign_in @user
  end

  describe 'user and guest access right' do
    before(:each) do
      admin1 = create(:admin)
      sign_out :user
      sign_in admin1
    end
    describe 'GET #index' do
      it 'redirects to the root url if you are not an admin' do
        sign_out :user
        get :index
        expect(response).to redirect_to root_url
      end
      it 'allows you to view the index if you are an admin' do
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of all reviews' do
        review2 = create(:review)
        get :index
        expect(assigns(:reviews)).to match_array([@review, review2])
      end
    end

    describe 'GET #show' do
      it 'redirects to the root url if you are not an admin' do
        sign_out :user
        get :show, id: @review
        expect(response).to redirect_to root_url
      end
      it 'assigns the requested review to @review' do
        get :show, id: @review
        expect(assigns(:review)).to eq @review
      end
      it 'renders the :show template' do
        get :show, id: @review
        expect(response).to render_template :show
      end
    end
  end

  describe 'user and admin access rights' do
    describe 'GET #new' do
      it 'guests cannot access the new review page' do
        sign_out :user
        get :new
        expect(response).to redirect_to root_url
      end
      it 'assigns a new review to @review' do
        get :new
        expect(assigns(:review)).to be_a_new(Review)
      end
      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it 'guests cannot access the edit review page' do
        sign_out :user
        get :edit, id: @review
        expect(response).to redirect_to root_url
      end
      it 'assigns the requested review to @review' do
        get :edit, id: @review
        expect(assigns(:review)).to eq @review
      end
      it 'renders the :edit template' do
        get :edit, id: @review
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        before(:each) do
          @business = create(:business)
          @user = create(:user)
        end
        it 'guests cannot create a review' do
          sign_out :user
          expect {
            post :create, review: attributes_for(:review, business_id: @business.id, user_id: @user.id)
          }.not_to change(Review, :count)
        end
        it 'saves the new review in the database' do
          expect {
            post :create, review: attributes_for(:review, business_id: @business.id, user_id: @user.id)
          }.to change(Review, :count).by(1)
        end
        it 'redirects to review#show' do
          post :create, review: attributes_for(:review, business_id: @business.id, user_id: @user.id)
          expect(response).to redirect_to business_path(assigns[:review].business_id)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new review in the database' do
          expect {
            post :create, review: attributes_for(:invalid_review)
          }.not_to change(Review, :count)
        end
        it 're-renders the :new template' do
          post :create, review: attributes_for(:invalid_review)
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context 'with valid attributes' do
        it "does not allow a guest to update a review" do
          sign_out :user
          patch :update, id: @review, review: attributes_for(:business, rating: 1)
          @review.reload
          expect(@review.rating).not_to eq(1)
        end
        it "only allows you to edit your reviews" do
          sign_out :user
          user2 = create(:user)
          sign_in user2
          patch :update, id: @review, review: attributes_for(:business, rating: 1)
          @review.reload
          expect(@review.rating).not_to eq(1)
        end
        it "locates the requested @review" do
          patch :update, id: @review, review: attributes_for(:business)
          expect(assigns(:review)).to eq(@review)
        end
        it "changes @review' attributes" do
          patch :update, id: @review, review: attributes_for(:business, rating: 1)
          @review.reload
          expect(@review.rating).to eq(1)
        end
        it "redirectes to the updated review" do
          patch :update, id: @review, review: attributes_for(:business)
            expect(response).to redirect_to business_path(@review.business_id)
        end
      end

      context 'with invalid attributes' do
        it "does not change the review' attributes" do
          rev_rating = @review.rating
          patch :update, id: @review, review: attributes_for(:invalid_review)
          @review.reload
          expect(@review.rating).to eq(rev_rating)
        end
        it 're-renders the :edit template' do
          patch :update, id: @review, review: attributes_for(:invalid_review)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'does not allow a guest to delete a review' do
        sign_out :user
        expect {
          delete :destroy, id: @review
        }.not_to change(Review, :count)
      end
      it 'only allows a user to delete their reviews' do
        sign_out :user
        user2 = create(:user)
        sign_in user2
        expect {
          delete :destroy, id: @review
        }.not_to change(Review, :count)
      end
      it 'deletes the review' do
        expect {
          delete :destroy, id: @review
        }.to change(Review, :count).by(-1)
      end
      it "redirects to review's business" do
        business = Business.find_by_id(@review.business_id)
        delete :destroy, id: @review
        expect(response).to redirect_to business_path(business)
      end
    end
  end
end
