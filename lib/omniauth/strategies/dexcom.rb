require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Dexcom < OmniAuth::Strategies::OAuth2
      option :name, 'dexcom'

      option :client_options, {
        :site => 'https://api.dexcom.com',
        :authorize_url => 'https://api.dexcom.com/v2/oauth2/login',
        :token_url => 'https://api.dexcom.com/v2/oauth2/token'
      }

      option :scope, 'offline_access'

      info do
        {
          'auth' => oauth2_access_token
        }
      end

      def callback_url
        full_host + script_name + callback_path
      end

      alias :oauth2_access_token :access_token

      def access_token
        ::OAuth2::AccessToken.new(client, oauth2_access_token.token, {
          :expires_in => oauth2_access_token.expires_in,
          :expires_at => oauth2_access_token.expires_at
        })
      end
    end
  end
end

OmniAuth.config.add_camelization 'dexcom', 'Dexcom'
