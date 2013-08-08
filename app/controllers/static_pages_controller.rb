class StaticPagesController < ApplicationController
  def home
    # Okay. Needs to process whether you're logged in and if so, how.
    # If you're not logged in, it just shows all venues.

    # If logged in with a student account, it plots all your favourites
    # in a different colour to other venues, and centres around your
    # saved Home address.
    if signed_in?
      @venues = current_user.venues
      @events = current_user.events
      @favs = @venues.to_gmaps4rails do |venue, marker|
        marker.infowindow render_to_string(:partial => "/venues/infowindow", :locals => { :venue => venue})
        marker.title "#{venue.name}"
        marker.picture({:picture => "/assets/tag_icons/favourite.png", :width => 32, :height => 32})
      end
      @atts = @events.to_gmaps4rails do |event, marker|
        marker.infowindow render_to_string(:partial => "/events/infowindow", :locals => { :event => event})
        marker.title "#{event.name}"
        marker.picture({:picture => "/assets/tag_icons/drinking society.png", :width => 32, :height => 32})
      end
      @house = current_user.to_gmaps4rails do |house, marker|
        marker.picture({:picture => "/assets/tag_icons/martial arts.png", :width => 32, :height => 32})
      end
      @json = (JSON.parse(@favs) + JSON.parse(@atts) + JSON.parse(@house)).to_json

    else
      @venues = Venue.all
      @json = @venues.to_gmaps4rails do |venue, marker|
        marker.infowindow render_to_string(:partial => "/venues/infowindow", :locals => { :venue => venue})
        marker.title "#{venue.name}"
        marker.picture({:picture => "/assets/tag_icons/assassins.png", :width => 32, :height => 32})
      end
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def testerpages
  end

end
