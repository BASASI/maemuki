Rails.application.config.middleware.use OmniAuth::Builder do
  secrets = Rails.application.secrets
  provider :twitter, secrets.twitter['key'], secrets.twitter['secret']
  provider :facebook, secrets.facebook['key'], secrets.facebook['secret']
end
