class User
  include Mongoid::Document
  include Mongoid::Slug

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

  slug :username, reserved: ['me', 'admin', 'root', 'user']

  # Find user by authentication uid and provider or email, and create a new user if not found
  # @param auth Hash
  # @return User
  def self.find_or_create_from_omniauth_hash(auth)
    uid_and_provider = {
        'authentications.uid' => auth[:uid],
        'authentications.provider' => auth[:provider]
    }
    # Select user by uid and provider or email
    user = self.or(uid_and_provider, { email: auth[:info][:email] }).first_or_create! do |user|
      user.email = auth[:info][:email]
      user.password = Devise.friendly_token
      user.username = auth[:info][:nickname]
      user.confirmed_at = Time.now
    end
  end

end
