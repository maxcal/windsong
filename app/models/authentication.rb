# Represents an 3rd party OAuth2 authentication
class Authentication
  include Mongoid::Document

  embedded_in :user

  field :provider, type: String
  field :uid # the providers unique id
  field :token
  field :expires_at

  # Constraints
  validates_inclusion_of :provider, in: ['facebook']
  validates_uniqueness_of :uid, scope: :provider
  validates_presence_of :token, :expires_at

  # Convert OmniAuth hash to Authentication attributes
  # @param auth_hash Hash
  # @return Hash
  def self.omniauth_hash_to_attributes(auth_hash)
    {
        uid: auth_hash[:uid],
        provider: auth_hash[:provider],
        token: auth_hash[:credentials][:token],
        expires_at: Time.at(auth_hash[:credentials][:expires_at])
    }
  end

  # @param auth_hash Hash
  # @return Authentication
  def self.find_or_initialize_from_omniauth_hash(auth_hash)
    attrs = self.omniauth_hash_to_attributes(auth_hash)
    self.find_or_initialize_by(attrs.slice(:uid, :provider)) do |auth|
      auth.token = attrs[:token]
      auth.expires_at = attrs[:expires_at]
    end
  end

  # @param auth_hash Hash
  # @return Boolean
  # @raise Mongoid::Errors::Validations if record is invalid
  def update_with_omniauth_hash(auth_hash)
    new_record? ? save! : update(Authentication.omniauth_hash_to_attributes(auth_hash))
  end
end