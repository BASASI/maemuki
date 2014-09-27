class CustomAuthenticationFailure < Devise::FailureApp 
  protected 
    def redirect_url
      '/users/sign_up'
    end 
end 
