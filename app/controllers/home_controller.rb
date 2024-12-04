class HomeController < ApplicationController
  def index
    if user_signed_in?
     # @playlists = current_user.spotify_playlists
    else
      @playlists = []
    end
  end
end