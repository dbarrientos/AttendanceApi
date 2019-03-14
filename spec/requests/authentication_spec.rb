require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # Authentication test suite
  describe 'POST /auth/admin_login' do
    # create test user
    let(:admin) { create(:user, role: 1) }
    let(:user) { create(:user) }
    # set headers for authorization
    let(:headers) { valid_headers.except('Authorization') }

    # set test valid and invalid credentials
    let(:valid_user_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end

    let(:valid_admin_credentials) do
      {
        email: admin.email,
        password: admin.password
      }.to_json
    end

    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    # set request.headers to our custon headers
    # before { allow(request).to receive(:headers).and_return(headers) }

    # returns auth token when request is admin valid
    context 'When request is valid for admin' do
      before { post '/auth/admin_login', params: valid_admin_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    # returns auth token when request is user valid
    context 'When request is valid for user' do
      before { post '/auth/user_login', params: valid_user_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    # returns failure message when request is invalid
    context 'When request is invalid for admin' do
      before { post '/auth/admin_login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end

    context 'When request is invalid for user' do
      before { post '/auth/user_login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end

    context 'When request is invalid for admin with user credentials' do
      before { post '/auth/admin_login', params: valid_user_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Unauthorized request/)
      end
    end

  end
end