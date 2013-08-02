class AttendingsController < ApplicationController
  before_action :signed_in_user

  def create
    @event = Event.find(params[:attending][:event_id])
    current_user.attend!(@event)
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end

  def destroy
    @event = Attending.find(params[:id]).event
    current_user.unattend!(@event)
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end
end
