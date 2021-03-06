class EventsController < ApplicationController

  before_action :organiser_account, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_or_admin,  only: [:edit, :update, :destroy]

  def index
    unless params[:venue_id]
      # Indexing from search
      @search = Event.search(params[:q])
      @search.build_condition if @search.conditions.empty?
      @search.sorts = 'distance_to(current_user) desc' if @search.sorts.empty?
      @events = @search.result.paginate(:page => params[:page])
      @json = @events.to_gmaps4rails
    else # Indexing via venue so only show that venue's events
      @events = Venue.find(params[:venue_id]).events.paginate(page: params[:page])
      @number = params[:venue_id]
    end
  end

  def show
    @event = Event.find(params[:id])
    @tags = @event.tags.paginate(page: params[:page])
    @json = @event.venue.to_gmaps4rails do |venue, marker|
      marker.infowindow render_to_string(:partial => "/events/infowindow", :locals => { :event => @event})
      marker.title "#{venue.name}"
      marker.picture({:picture => "/assets/tag_icons/assassins.png", :width => 32, :height => 32})
    end
  end

  def create
    @event = Venue.find(event_params[:venue_id]).events.build(event_params)
    @event.day = 
    if @event.save
      flash[:success] = "Event created!"
      redirect_to @event
    else
      flash[:error] = "Couldn't create event"
      render 'static_pages/home'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event details updated"
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to Venue.find(@event.venue_id)
  end

  def tagged
    @title = "Tags"
    @event = Event.find(params[:id])
    @tags = @event.tags.paginate(page: params[:page])
    render 'show_tags'
  end

  private

    def event_params
      params.require(:event).permit(:name, :description, :start_time, :end_time, :tags,
                                    :venue_id, :day, :contact, :website, :gender)
    end


    def correct_or_admin
      current_venue = Venue.find(Event.find(params[:id]).venue_id)
      redirect_to(root_path) unless signed_in? && ((current_venue.user_id == current_user.id) || current_user.admin?)
    end

end
