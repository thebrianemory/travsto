require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @comment = create(:comment)
    @trip = Trip.find_by_id(@comment.trip_id)
    sign_in @user = User.find_by_id(@comment.user_id)
  end

  describe 'guest and user access rights' do
    before(:each) do
      sign_out :user
      sign_in admin1 = create(:admin)
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
      it 'populates an array of all comments' do
        comment2 = create(:comment)
        get :index
        expect(assigns(:comments)).to match_array([@comment, comment2])
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
  end

  describe 'user and admin access rights' do
    describe 'GET #new' do
      it 'assigns a new comment to @comment' do
        get :new
        expect(assigns(:comment)).to render_template :new
      end
      it 'does not allow a guest cannot view the new comment page' do
        sign_out :user
        get :new
        expect(response).to redirect_to root_url
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
      it 'does not allow a guest cannot view the edit comment page' do
        sign_out :user
        get :edit, id: @comment
        expect(response).to redirect_to root_url
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
        it 'does not allow a guest to create a new comment' do
          sign_out :user
          expect {
            post :create, comment: attributes_for(:comment, user_id: @user.id, trip_id: @trip.id)
          }.not_to change(Comment, :count)
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
        it "does not allow a guest to update a comment" do
          sign_out :user
          patch :update, id: @comment, comment: attributes_for(:comment, content: "This is lame.")
          @comment.reload
          expect(@comment.content).not_to eq("This is lame.")
        end
        it "only allows you to update your comments" do
          sign_out :user
          sign_in user2 = create(:user)
          patch :update, id: @comment, comment: attributes_for(:comment, content: "This is lame.")
          @comment.reload
          expect(@comment.content).not_to eq("This is lame.")
        end
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
      it 'does not let a guest delete a comment' do
        sign_out :user
        expect {
          delete :destroy, id: @comment
        }.not_to change(Comment, :count)
      end
      it 'only allows you to delete your comments' do
        sign_out :user
        sign_in user2 = create(:user)
        expect {
          delete :destroy, id: @comment
        }.not_to change(Comment, :count)
      end
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
end
