class StreamingServicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @streaming_services = StreamingService.where(user: current_user)
  end

  def show
    @streaming_service = StreamingService.find(params[:id])
  end

  def connect_spotify
    redirect_to user_spotify_omniauth_authorize_path
  end
end