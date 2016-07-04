class CallbacksController < Devise::OmniauthCallbacksController
    def facebook
      if request.env["omniauth.auth"].info.email.blank?
        redirect_to "/auth/facebook?auth_type=rerequest&scope=email"
      else
        @user = User.from_omniauth(request.env["omniauth.auth"])
        sign_in_and_redirect @user
      end
    end
end
