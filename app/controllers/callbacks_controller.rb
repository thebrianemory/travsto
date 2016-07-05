class CallbacksController < Devise::OmniauthCallbacksController
    def facebook
      if request.env["omniauth.auth"].info.email.blank?
        redirect_to "/auth/facebook?auth_type=rerequest&scope=email"
      elsif user = User.find_by(email: request.env["omniauth.auth"].info.email)
        user.update(uid: request.env["omniauth.auth"].uid)
        user.update(provider: request.env["omniauth.auth"].provider)
        user.save
        sign_in_and_redirect user
      else
        @user = User.from_omniauth(request.env["omniauth.auth"])
        sign_in_and_redirect @user
      end
    end
end
