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
        get :show, id: @trip
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
      it 'redirects you if you are a guest' do
        sign_out :user
        get :new
        expect(response).to redirect_to root_url
      end
      it 'assigns a new trip to @trip' do
        get :new
        expect(assigns(:trip)).to be_a_new(Trip)
      end
      it 'renders the :new template if you are signed in' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it 'redirects you if you are a guest' do
        sign_out :user
        get :edit, id: @trip
        expect(response).to redirect_to root_url
      end
      it 'allows you to only edit your trips' do
        sign_out :user
        sign_in user2 = create(:user)
        get :edit, id: @trip
        expect(response).to redirect_to root_url
      end
      it 'allows admins to edit any trip' do
        sign_out :user
        sign_in admin1 = create(:admin)
        get :edit, id: @trip
        expect(response).to render_template :edit
      end
      it 'assigns the requested trip to @trip' do
        get :edit, id: @trip
        expect(assigns(:trip)).to eq @trip
      end
      it 'renders the :edit template for your trips' do
        get :edit, id: @trip
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        before(:each) do
          @user = create(:user)
        end
        it 'only allows signed in users to create a trip' do
          sign_out :user
          expect {
            post :create, trip: attributes_for(:trip, user_id: @user.id)
          }.to raise_error(NoMethodError)
        end
        it 'saves the new trip in the database' do
          expect {
            post :create, trip: attributes_for(:trip, user_id: @user.id)
          }.to change(Trip, :count).by(1)
        end
        it 'redirects to trip#show' do
          post :create, trip: attributes_for(:trip, user_id: @user.id)
          expect(response).to redirect_to trip_path(assigns[:trip])
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new trip in the database' do
          expect {
            post :create, trip: attributes_for(:invalid_trip)
          }.not_to change(Trip, :count)
        end
        it 're-renders the :new template' do
          post :create, trip: attributes_for(:invalid_trip)
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context 'with valid attributes' do
        it 'does not allow guests to update a trip' do
          sign_out :user
          patch :update, id: @trip, trip: attributes_for(:trip, title: "Okay so we went on a trip")
          @trip.reload
          expect(@trip.title).not_to eq('Okay so we went on a trip')
        end
        it "locates the requested @trip" do
          patch :update, id: @trip, trip: attributes_for(:trip)
          expect(assigns(:trip)).to eq(@trip)
        end
        it "changes @trip' attributes" do
          patch :update, id: @trip, trip: attributes_for(:trip, title: "Okay so we went on a trip")
          @trip.reload
          expect(@trip.title).to eq('Okay so we went on a trip')
        end
        it "redirectes to the updated trip" do
          patch :update, id: @trip, trip: attributes_for(:trip)
          expect(response).to redirect_to @trip
        end
      end

      context 'with invalid attributes' do
        it "does not change the trip' attributes" do
          trip_title = @trip.title
          patch :update, id: @trip, trip: attributes_for(:invalid_trip)
          @trip.reload
          expect(@trip.title).to eq(trip_title)
        end
        it 're-renders the :edit template' do
          patch :update, id: @trip, trip: attributes_for(:invalid_trip)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'does not allow guests to update a trip' do
        sign_out :user
        delete :destroy, id: @trip
        expect(response).to redirect_to root_url
      end
      it 'only allows you to delete your trips' do
        sign_out :user
        sign_in user2 = create(:user)
        delete :destroy, id: @trip
        expect(response).to redirect_to root_url
      end
      it 'allows an admin to delete any trip' do
        sign_out :user
        sign_in admin1 = create(:admin)
        expect {
          delete :destroy, id: @trip
        }.to change(Trip, :count).by(-1)
      end
      it 'deletes the trip' do
        expect {
          delete :destroy, id: @trip
        }.to change(Trip, :count).by(-1)
      end
      it 'redirects to trips#index' do
        delete :destroy, id: @trip
        expect(response).to redirect_to trips_path
      end
    end
  end
end
