require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  before(:each) do
    @trip = create(:trip)
    sign_in @user = User.find_by_id(@trip.user_id)
  end

  describe "Guest access" do
    before(:each) do
      sign_out :user
    end
    describe 'GET #index' do
      it 'populates an array of all trips' do
        trip2 = create(:trip)
        get :index
        expect(assigns(:trips)).to match_array([@trip, trip2])
      end
      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
      it "allows viewing of the user's trips" do
        get :index, id: @user
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      before(:each) do
        get :show, user_id: @user, id: @trip
      end
      it 'assigns the requested trip to @trip' do
        expect(assigns(:trip)).to render_template :show
      end
      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end
  end

  describe "User and admin access" do
    describe 'GET #new' do
      it 'assigns a new trip to @trip' do
        get :new, user_id: @user, id: @trip
        expect(assigns(:trip)).to be_a_new(Trip)
      end
      it 'renders the :new template if you are signed in' do
        get :new, user_id: @user, id: @trip
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it 'allows you to only edit your trips' do
        sign_out :user
        sign_in user2 = create(:user)
        get :edit, user_id: @user, id: @trip
        expect(response).to redirect_to root_url
      end
      it 'allows admins to edit any trip' do
        sign_out :user
        sign_in admin1 = create(:admin)
        get :edit, user_id: @user, id: @trip
        expect(response).to render_template :edit
      end
      it 'assigns the requested trip to @trip' do
        get :edit, user_id: @user, id: @trip
        expect(assigns(:trip)).to eq @trip
      end
      it 'renders the :edit template for your trips' do
        get :edit, user_id: @user, id: @trip
        expect(response).to render_template :edit
      end
    end

    describe 'DELETE #destroy' do
      it 'does not allow guests to update a trip' do
        sign_out :user
        delete :destroy, user_id: @user, id: @trip
        expect(response).to redirect_to root_url
      end
      it 'only allows you to delete your trips' do
        sign_out :user
        sign_in user2 = create(:user)
        delete :destroy, user_id: @user, id: @trip
        expect(response).to redirect_to root_url
      end
      it 'redirects to trips#index' do
        delete :destroy, user_id: @user, id: @trip
        expect(response).to redirect_to trips_path
      end
    end
  end
end
