class Tag < ActiveRecord::Base
  has_many :relationships, dependent: :destroy
end
