class Tag < ActiveRecord::Base
  has_many :events, through: :relationships
  has_many :relationships, dependent: :destroy
end
