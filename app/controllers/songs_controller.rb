class SongsController < ApplicationController
  def index
    @songs = if params[:keywords]
                 Song.where('name ilike ?',"%#{params[:keywords]}%")
               else
                 []
               end
  end
end

