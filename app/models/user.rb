class User < ActiveRecord::Base
  has_many :events, through: :favourites
  has_many :diary_entries # oh them lovely plurals
  has_many :messages, foreign_key: "receiver_id", dependent: :destroy
  has_many :messages, foreign_key: "sender_id", dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :reviews, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  acts_as_gmappable
  after_validation :geocode

  if :home_address?
    geocoded_by :gmaps4rails_address
  else
    geocoded_by :ip_address
  end

  def ip_address
    request.remote_ip
  end

  def gmaps4rails_address
    "#{home_address}, #{home_postcode}"
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def is_favourite?(event)
    favourites.find_by(event_id: event.id)
  end

  def favourite!(event)
    favourites.create!(event_id: event.id)
  end

  def unfavourite!(event)
    favourites.find_by(event_id: event.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end

