OmniAuth.config.logger = Rails.logger

OmniAuth.config.full_host = lambda do |env|
    scheme         = env['rack.url_scheme']
    local_host     = env['HTTP_HOST']
    forwarded_host = env['HTTP_X_FORWARDED_HOST']
    forwarded_host.blank? ? "#{scheme}://#{local_host}" : "#{scheme}://#{forwarded_host}"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, LH_CONFIG[:twitter_key], LH_CONFIG[:twitter_secret]
  provider :facebook, LH_CONFIG[:facebook_key], LH_CONFIG[:facebook_secret]
  provider :google_oauth2, LH_CONFIG[:google_key], LH_CONFIG[:google_secret]
  provider :github, LH_CONFIG[:github_key], LH_CONFIG[:github_secret]
end
