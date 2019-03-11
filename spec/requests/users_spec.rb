require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end
  let(:users) { create_list(:user, 5) }
  let(:user_id) { users.last.id }

  # User signup test suite
  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Firstname can't be blank, Lastname can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end

  describe 'PUT /users/:id' do
    let(:valid_attributes) { { firstname: 'David', dni: Faker::ChileRut.full_rut }.to_json }

    context 'when the record exists' do
      before { put "/users/#{user_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end