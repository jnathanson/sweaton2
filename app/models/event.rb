class Event < ActiveRecord::Base
  serialize :schedule, Hash

  belongs_to :venue
  has_many :tags, through: :relationships
  has_many :attendings, dependent: :destroy
  has_many :relationships, dependent: :destroy

  default_scope -> { order('start_time ASC') }
  validates :venue_id, presence: true
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 200 }
  validates :start_time, presence: true
  # End_time not necessary, it should automatically end 30 minutes after start_time if left blank (but this is impossible with form format, you could only do that by sending a direct html request, not out of the question though)

  acts_as_gmappable
  geocoded_by :gmaps4rails_address
  after_validation :geocode#, :if => :address_changed?

  def gmaps4rails_address
    "#{venue.gmaps4rails_address}"
  end

  def tagged?(property)
    relationships.find_by(tag_id: property.id)
  end

  def tagify!(property)
    relationships.create!(tag_id: property.id)
  end

  def untagify!(property)
    relationships.find_by(tag_id: property.id).destroy
  end

end
