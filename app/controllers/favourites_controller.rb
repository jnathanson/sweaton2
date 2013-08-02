class FavouritesController < ApplicationController
  before_action :signed_in_user

  def create
    @venue = Venue.find(params[:favourite][:venue_id])
    current_user.enfavourite!(@venue)
    respond_to do |format|
      format.html { redirect_to @venue }
      format.js
    end
  end

  def destroy
    @venue = Favourite.find(params[:id]).venue
    current_user.unfavourite!(@venue)
    respond_to do |format|
      format.html { redirect_to @venue }
      format.js
    end
  end
end
