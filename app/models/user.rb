class User < ApplicationRecord
  has_many :streaming_services, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :spotify]

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.fullname = auth.info.name
      user.avatar_url = auth.info.image
    end
      
    if auth.provider == 'spotify' && user.persisted?
      
      user.update!(
        provider: auth.provider,
        spotify_uid: auth.uid,
        spotify_access_token: auth.credentials.token,
        spotify_refresh_token: auth.credentials.refresh_token
      )
      user.reload
      user.streaming_services.find_or_create_by!(service_name: 'Spotify') do |service|
        service.name = auth.service_name
        service.spotify_uid = auth.uid
        service.spotify_access_token = auth.credentials.token 
      end
    end 

      user
  end

  def spotify
    @spotify ||= RSpotify::User.new(spotify_hash)
  end

  def spotify_playlists
    spotify.playlists
  end

  def spotify_hash
    {
      'credentials' => {
        'token' => spotify_access_token,
        'refresh_token' => spotify_refresh_token
      },
      'info' => {
        'id' => spotify_uid
      }
    }
  end
end