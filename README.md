# OmniAuth Dexcom OAuth2 Strategy

[![Build Status](https://travis-ci.org/bartimaeus/omniauth-dexcom-oauth2.svg?branch=master)](https://travis-ci.org/bartimaeus/omniauth-dexcom-oauth2)
[![Gem Version](https://badge.fury.io/rb/omniauth-dexcom-oauth2.svg)](https://badge.fury.io/rb/omniauth-dexcom-oauth2)

A Dexcom OAuth2 strategy for OmniAuth.

For more details, read the [Dexcom documentation](https://developer.dexcom.com/authentication)

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-dexcom-oauth2'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-dexcom-oauth2

## Usage

Register your application with dexcom to receive an API key: https://developer.dexcom.com/

This is an example that you might put into a Rails initializer at `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dexcom, ENV['DEXCOM_CLIENT_ID'], ENV['DEXCOM_CLIENT_SECRET'], :scope => 'offline_access'
end
```

You can now access the OmniAuth Dexcom OAuth2 URL: `/auth/dexcom`.

## Granting Member Permissions to Your Application

With the Dexcom API, you have the ability to specify which permissions you want users to grant your application.
For more details, read the [Dexcom documentation](https://developer.dexcom.com/scopes-access)

The five scopes of data access:

- Estimated Blood Glucose Levels
- Calibration Data
- Events Entry Data
- Device Details
- CGM Statistics

You can configure the scope option:

```ruby
provider :dexcom, ENV['DEXCOM_CLIENT_ID'], ENV['DEXCOM_CLIENT_SECRET'], :scope => 'offline_access'
```

## Contributing

1.  Fork it
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create new Pull Request
