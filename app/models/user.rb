
class User
  include Mongoid::Document
  include Mongoid::Slug
  include Presentable

  has_many :stations
  # @!attribute authentications
  #   The authentications embedded in this user
  #   @see Authentication
  #   @return [Array]
  embeds_many :authentications

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :validatable, :confirmable

  devise :omniauthable, :omniauth_providers => [:facebook]

  rolify

  # @!attribute username
  #   @return [String]
  field :username, type: String
  # @!attribute email
  #   @return [String]
  field :email,              type: String, default: ""
  # @!attribute encrypted_password [r]
  #   @return [String]
  field :encrypted_password, type: String, default: ""

  ## = Recoverable ===========================================
  # @!attribute reset_password_token
  #   Used by Devise recoverable
  #   @return [String]
  field :reset_password_token,   type: String
  ## Recoverable
  # @!attribute reset_password_sent_at
  #   Used by Devise recoverable
  #   @return [Time]
  field :reset_password_sent_at, type: Time

  ## Rememberable
  # @!attribute remember_created_at
  #   @return [Time]
  field :remember_created_at, type: Time

  ## Confirmable

  # @!attribute confirmation_token
  #   @return [String]
  field :confirmation_token,   type: String
  # @!attribute confirmed_at
  #   @return [Time]
  field :confirmed_at,         type: Time
  # @!attribute confirmation_sent_at
  #   @return [Time]
  field :confirmation_sent_at, type: Time
  # @!attribute unconfirmed_email
  #   @return [String]
  field :unconfirmed_email,    type: String

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  # @!attribute login
  #   Virtual attribute for authenticating by either username or email
  #   @return (String)
  attr_accessor :login

  validates_uniqueness_of :username, allow_nil: true

  # @!attribute slug
  #   Slugged version of username used to create urls
  #   @return (String)
  slug :username, reserved: %w[me, admin, root, user, password]

  # Convert OmniAuth AuthHash to User attributes
  # @param auth_hash (OmniAuth::AuthHash)
  # @return (Hash)
  def self.omniauth_hash_to_attributes(auth_hash)
    {
        email: auth_hash[:info][:email],
        password: Devise.friendly_token,
        username: auth_hash[:info][:nickname],
        confirmed_at: Time.now
    }
  end

  # Find user by authentication uid and provider or email, and create a new user if not found
  # @param auth_hash (OmniAuth::AuthHash)
  # @return (User)
  def self.find_or_create_from_omniauth_hash(auth_hash)
    uid_and_provider = {
        'authentications.uid' => auth_hash[:uid],
        'authentications.provider' => auth_hash[:provider]
    }
    attrs = self.omniauth_hash_to_attributes(auth_hash)
    self.or(uid_and_provider, attrs.slice(:email)).first_or_create!(attrs)
  end

end