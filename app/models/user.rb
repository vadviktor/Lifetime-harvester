class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

  has_many :tasks

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.name     = auth.info.name

      if auth.provider.eql? 'facebook'
        user.oauth_token      = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      end

      user.save!
    end
  end
end
