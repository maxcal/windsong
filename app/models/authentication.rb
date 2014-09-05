# Represents an 3rd party OAuth2 authentication
class Authentication
  include Mongoid::Document
  include Presentable

  embedded_in :user
  # @!attribute provider
  #   The unique name of the authentication provider
  #   @return [String]
  field :provider, type: String
  # @!attribute uid
  #   the providers unique id
  #   @return [String]
  field :uid, type: String # the providers unique id
  # @!attribute token
  #   Authorization token from provider, Used when making ajax requests to provider on behalf of user
  #   @return [String]
  field :token, type: String
  # @!attribute expires_at
  #   When the token expires
  #   @return [Time]
  field :expires_at, type: Time

  # Constraints
  validates_inclusion_of :provider, in: User.omniauth_providers.map { |p| p.to_s }
  validates_uniqueness_of :uid, scope: :provider
  validates_presence_of :token, :expires_at

  # Convert OmniAuth hash to Authentication attributes
  # @param [Hash] auth_hash
  # @return [Hash]
  def self.omniauth_hash_to_attributes(auth_hash)
    {
        uid: auth_hash[:uid],
        provider: auth_hash[:provider],
        token: auth_hash[:credentials][:token],
        expires_at: Time.at(auth_hash[:credentials][:expires_at])
    }
  end

  # @param [Hash] auth_hash
  # @return [Authentication]
  def self.find_or_initialize_from_omniauth_hash(auth_hash)
    attrs = self.omniauth_hash_to_attributes(auth_hash)
    self.find_or_initialize_by(attrs.slice(:uid, :provider)) do |auth|
      auth.token = attrs[:token]
      auth.expires_at = attrs[:expires_at]
    end
  end

  # @param [Hash] auth_hash
  # @return [Boolean]
  # @raise [Mongoid::Errors::Validations] if record is invalid
  def update_with_omniauth_hash(auth_hash)
    new_record? ? save! : update(Authentication.omniauth_hash_to_attributes(auth_hash))
  end
end