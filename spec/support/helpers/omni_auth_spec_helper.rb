module OmniAuthSpecHelper


  # @param provider Symbol
  # @param attributes Hash (optional)
  # @return OmniAuth::AuthHash
  def valid_credentials(provider, attributes = {})

    # The mock_auth configuration allows you to set per-provider (or default) authentication
    # hashes to return during integration testing.
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
       provider: 'facebook',
       uid: '1234567',
       info: {
           nickname: 'jbloggs',
           email: 'joe@bloggs.com',
           name: 'Joe Bloggs',
           first_name: 'Joe',
           last_name: 'Bloggs',
           image: 'http://graph.facebook.com/1234567/picture?type=square',
           urls: { Facebook: 'http://www.facebook.com/jbloggs' },
           location: 'Palo Alto, California',
           verified: true
       },
       credentials: {
           token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
           expires_at: 1321747205, # when the access token expires (it always will)
           expires: true # this will always be true
       }
    })

    # This information will automatically be merged with the default info so it will be a valid response.
    OmniAuth.config.add_mock(provider, attributes)
    OmniAuth.config.mock_auth[provider]

  end

  # @param provider Symbol
  def invalid_credentials(provider)
    OmniAuth.config.mock_auth[provider] = :invalid_credentials
    OmniAuth.config.mock_auth[provider]
  end

end