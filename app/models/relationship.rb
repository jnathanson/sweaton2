class Relationship < ActiveRecord::Base
  belongs_to :tag
  belongs_to :event
  validates :event_id, presence: true
  validates :tag_id, presence: true
end
