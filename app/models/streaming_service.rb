class StreamingService < ApplicationRecord
  belongs_to :user
  
  validates :service_name, presence: true
  validates :spotify_uid, presence: true
  validates :spotify_access_token, presence: true
  
  def connect_account(auth_data)
    update(
      spotify_uid: auth_data.uid,
      spotify_access_token: auth_data.credentials.token
    )
  end
end