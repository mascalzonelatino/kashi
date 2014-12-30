class SongsController < ApplicationController
  skip_before_filter :verify_authenticity_token 

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


  def create
    @song = Song.new(params.require(:song).permit(:name,:lyrics))
    @song.save
    render 'show', status: 201
  end

  def update
    song = Song.find(params[:id])
    song.update_attributes(params.require(:song).permit(:name,:lyrics))
    head :no_content
  end

  def destroy
    song = Song.find(params[:id])
    song.destroy
    head :no_content
  end  

end

