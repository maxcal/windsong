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
    auth_hash.slice(:uid, :provider).merge(
        token: auth_hash[:credentials][:token],
        expires_at: Time.at(auth_hash[:credentials][:expires_at])
    )
  end

  # @param auth_hash Hash
  # @return Authentication
  def self.find_or_initialize_from_omniauth_hash(auth_hash)
    attrs = self.omniauth_hash_to_attributes(auth_hash)
    self.with(attrs).find_or_initialize_by(attrs.slice(:uid, :provider))
  end

  # @param auth_hash Hash
  # @return Boolean
  def update_with_omniauth_hash(auth_hash)
    update(Authentication.omniauth_hash_to_attributes(auth_hash))
  end
end