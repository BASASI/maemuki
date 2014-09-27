class Identity < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :uid, :provider, :token
  validates_uniqueness_of :provider, scope: :uid
  validates_uniqueness_of :provider, scope: :user_id

  def self.create_from_omniauth(auth)
    create!(
      provider: auth.provider,
      uid: auth.uid,
      token: auth.credentials.token,
      secret: auth.credentials.secret,
      expires_at: auth.credentials.expires_at
    )
  end
end
