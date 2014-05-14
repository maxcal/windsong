# Represents an 3rd party OAuth2 authentication
class Authentication
  include Mongoid::Document
  belongs_to :user

  field :provider, type: String
  field :uid # the providers unique id
  field :token
  field :expires_at

  # Constraints
  validates_inclusion_of :provider, in: ['facebook']
  validates_uniqueness_of :uid, scope: :provider
  validates_presence_of :token, :expires_at

  # @param auth_hash Hash
  # @return Authentication
  def self.find_or_create_from_omniauth_hash(auth_hash)
    uid = auth_hash.try(:[], :uid)
    provider = auth_hash.try(:[], :provider)

    self.find_or_create_by(uid: uid, provider: provider) do |a|
      a.provider = provider
      a.uid = uid
      a.token = auth_hash.try(:[], :credentials).try(:[], :token)
      # Avoid calling Time.at with nil
      expires = auth_hash.try(:[], :credentials).try(:[], :expires_at)
      a.expires_at = expires ? Time.at(expires) : nil
    end
  end

  # @param auth_hash Hash
  # @return Boolean
  def update_with_omniauth_hash(auth_hash)
    self.token = auth_hash[:credentials][:token] if auth_hash.try(:[], :credentials).try(:[], :token)
    self.expires_at = Time.at(auth_hash[:credentials][:expires_at]) if auth_hash.try(:[], :credentials).try(:[], :expires_at)
    save!
  end
end