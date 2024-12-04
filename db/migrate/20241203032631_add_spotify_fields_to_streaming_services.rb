class AddSpotifyFieldsToStreamingServices < ActiveRecord::Migration[7.0]
  def change
    add_column :streaming_services, :spotify_uid, :string
    add_column :streaming_services, :spotify_access_token, :string
  end
end
