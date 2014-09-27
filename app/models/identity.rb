class Identity < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :uid, :provider, :token
  validates_uniqueness_of :provider, scope: :uid
  validates_uniqueness_of :provider, scope: :user_id

  def twitter_client
    if self.provider == 'twitter'
      Twitter::REST::Client.new do |config|
        secrets = Rails.application.secrets
        config.consumer_key = secrets.twitter['key']
        config.consumer_secret = secrets.twitter['secret']
        config.access_token = self.token
        config.access_token_secret = self.secret
      end
    end
  end

  def statuses(oldest_id = nil)
    client = twitter_client
    opts = {count: 200, include_rts: false}
    # TODO: 最大で180回？
    (1..5).map { |i|
      client.user_timeline(oldest_id.nil? ? opts : opts.merge(max_id: oldest_id)).tap do |tweets|
        oldest_id = tweets.last.id - 1
      end
    }.flatten
  end

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
