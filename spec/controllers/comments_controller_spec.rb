require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @comment = create(:comment)
    @user = User.find_by_id(@comment.user_id)
    @trip = Trip.find_by_id(@comment.trip_id)
  end
  login_user

  describe 'GET #index' do
    it 'redirects to the root url' do
      get :index
      expect(response).to redirect_to root_url
    end
  end

  describe 'GET #show' do
    it 'assigns the requested comment to @comment' do
      get :show, id: @comment
      expect(assigns(:comment)).to eq @comment
    end
    it 'renders the :show template' do
      get :show, id: @comment
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new comment to @comment' do
      get :new
      expect(assigns(:comment)).to render_template :new
    end
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested comment to @comment' do
      get :edit, id: @comment
      expect(assigns(:comment)).to eq @comment
    end
    it 'renders the :edit template' do
      get :edit, id: @comment
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before(:each) do
        @user = create(:user)
        @trip = create(:trip)
      end
      it 'saves the new comment in the database' do
        expect {
          post :create, comment: attributes_for(:comment, user_id: @user.id, trip_id: @trip.id)
        }.to change(Comment, :count).by(1)
      end
      it 'redirects to comment#show' do
        post :create, comment: attributes_for(:comment, user_id: @user.id, trip_id: @trip.id)
        expect(response).to redirect_to trip_path(assigns[:comment].trip_id)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new comment in the database' do
        expect {
          post :create, comment: attributes_for(:invalid_comment)
        }.not_to change(Comment, :count)
      end
      it 're-renders the :new template' do
        post :create, comment: attributes_for(:invalid_comment)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it "locates the requested @comment" do
        patch :update, id: @comment, comment: attributes_for(:comment)
        expect(assigns(:comment)).to eq(@comment)
      end
      it "changes @comment' attributes" do
        patch :update, id: @comment, comment: attributes_for(:comment, content: "This is lame.")
        @comment.reload
        expect(@comment.content).to eq("This is lame.")
      end
      it "redirectes to the updated comment" do
        patch :update, id: @comment, comment: attributes_for(:comment)
        expect(response).to redirect_to trip_path(@comment.trip_id)
      end
    end

    context 'with invalid attributes' do
      it "does not change the comment' attributes" do
        com_content = @comment.content
        patch :update, id: @comment, comment: attributes_for(:invalid_comment)
        @comment.reload
        expect(@comment.content).to eq(com_content)
      end
      it 're-renders the :edit template' do
        patch :update, id: @comment, comment: attributes_for(:invalid_comment)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the comment' do
      expect {
        delete :destroy, id: @comment
      }.to change(Comment, :count).by(-1)
    end
    it "redirects to comment's trip" do
      trip = Trip.find_by_id(@comment.trip_id)
      delete :destroy, id: @comment
      expect(response).to redirect_to trip_path(trip)
    end
  end
end
