class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable, :trackable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  mount_uploader :image, UserUploader

  has_many :identities, dependent: :delete_all

  def has_result?
    self.last_analyzed_at.present?
  end

  def has_provider?(provider)
    self.identities.any? { |i| i.provider == provider.to_s }
  end

  def add_identity(auth)
    self.identities << Identity.create_from_omniauth(auth)
  end

  def self.find_by_auth_params(auth)
    Identity.find_by(provider: auth.provider, uid: auth.uid).try(:user)
  end

  def self.create_from_omniauth(auth)
    transaction do
      User.create!(
        name: auth.info.nickname.presence || auth.info.name.gsub(/\s/, '_'),
        screen_name: auth.info.name,
        image: auth.info.image
      ).tap { |user| user.add_identity(auth) }
    end
  end
end
