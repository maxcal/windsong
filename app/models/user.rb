class User
  include Mongoid::Document
  include Mongoid::Slug
  include Presentable

  rolify

  embeds_many :authentications

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  devise :omniauthable, :omniauth_providers => [:facebook]

  ## Database authenticatable
  field :username, type: String
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login
  validates_uniqueness_of :username, allow_nil: true

  slug :username, reserved: %w[me, admin, root, user]

  # Convert OmniAuth AuthHash to User attributes
  # @param auth_hash OmniAuth::AuthHash
  # @return Hash
  def self.omniauth_hash_to_attributes(auth_hash)
    {
        email: auth_hash[:info][:email],
        password: Devise.friendly_token,
        username: auth_hash[:info][:nickname],
        confirmed_at: Time.now
    }
  end

  # Find user by authentication uid and provider or email, and create a new user if not found
  # @param auth_hash OmniAuth::AuthHash
  # @return User
  def self.find_or_create_from_omniauth_hash(auth_hash)
    uid_and_provider = {
        'authentications.uid' => auth_hash[:uid],
        'authentications.provider' => auth_hash[:provider]
    }
    attrs = self.omniauth_hash_to_attributes(auth_hash)
    self.or(uid_and_provider, attrs.slice(:email)).first_or_create!(attrs)
  end

end