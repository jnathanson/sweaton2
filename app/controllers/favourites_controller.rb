class FavouritesController < ApplicationController
  before_action :signed_in_user

  def create
    @event = Event.find(params[:favourite][:event_id])
    current_user.favourite!(@event)
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end

  def destroy
    @event = Favourite.find(params[:id]).event
    current_user.unfavourite!(@event)
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end
end
