class Event < ActiveRecord::Base
  belongs_to :venue
  has_many :tags, through: :relationships
  has_many :attendings, dependent: :destroy
  has_many :relationships, dependent: :destroy

  default_scope -> { order('start_time ASC') }
  validates :venue_id, presence: true
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 200 }

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
