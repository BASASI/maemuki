class CustomAuthenticationFailure < Devise::FailureApp 
  protected 
    def redirect_url
      '/users/new'
    end 
end 
