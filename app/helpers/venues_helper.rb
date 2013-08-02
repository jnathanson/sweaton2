module VenuesHelper

  # Returns the Gravatar (http://gravatar.com/) for the given venue. TODO NOT PERMANENT - need an image upload facility.
  def gravatar_for(venue, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(venue.name.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: venue.name, class: "gravatar")
  end
end
