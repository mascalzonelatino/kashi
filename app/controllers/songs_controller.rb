class SongsController < ApplicationController
  def index
    @songs = if params[:keywords]
                 Song.where('name ilike ?',"%#{params[:keywords]}%")
               else
                 []
               end
  end

  def show
    @song = Song.find(params[:id])
  end
end

