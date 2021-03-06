class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    authenticate
  end

  def twitter
    authenticate
  end

  private

    def authenticate
      auth = request.env["omniauth.auth"]
      user = User.find_by_auth_params(auth)
      if user_signed_in?
        current_user.add_identity(auth) if user.blank?
      else
        if user.blank?
          user = User.create_from_omniauth(auth)
          Resque.enqueue(StatusAnalyzer, user.id)
        end
        sign_in user
      end
      redirect_to root_path
    end
end
