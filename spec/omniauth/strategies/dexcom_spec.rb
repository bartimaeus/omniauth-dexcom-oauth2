require 'spec_helper'
require 'omniauth-dexcom-oauth2'

describe OmniAuth::Strategies::Dexcom do
  subject { OmniAuth::Strategies::Dexcom.new(nil) }

  it 'adds camelization for itself' do
    expect(OmniAuth::Utils.camelize('dexcom')).to eq('Dexcom')
  end

  describe '#client' do
    it 'has correct Dexcom site' do
      expect(subject.client.site).to eq('https://api.dexcom.com')
    end

    it 'has correct `authorize_url`' do
      expect(subject.client.options[:authorize_url]).to eq('https://api.dexcom.com/v2/oauth2/login')
    end

    it 'has correct `token_url`' do
      expect(subject.client.options[:token_url]).to eq('https://api.dexcom.com/v2/oauth2/token')
    end
  end

  describe '#info' do
    let(:access_token) { instance_double OAuth2::AccessToken }
    let(:parsed_response) {}

    before :each do
      allow(subject).to receive(:access_token).and_return access_token
    end

    it 'returns parsed responses using access token' do
      expect(subject.info).to have_key 'auth'
    end
  end

  describe '#access_token' do
    let(:expires_in) { 3600 }
    let(:expires_at) { 946688400 }
    let(:token) { 'token' }
    let(:access_token) do
      instance_double OAuth2::AccessToken, :expires_in => expires_in,
        :expires_at => expires_at, :token => token
    end

    before :each do
      allow(subject).to receive(:oauth2_access_token).and_return access_token
    end

    specify { expect(subject.access_token.expires_in).to eq expires_in }
    specify { expect(subject.access_token.expires_at).to eq expires_at }
  end

  describe '#authorize_params' do
    describe 'scope' do
      before :each do
        allow(subject).to receive(:session).and_return({})
      end

      it 'sets default scope' do
        expect(subject.authorize_params['scope']).to eq('offline_access')
      end
    end
  end
end
