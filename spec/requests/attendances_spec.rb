require 'rails_helper'

RSpec.describe 'Attendances API', type: :request do
  # initialize test data 
  let!(:attendances) { create_list(:attendance, 10) }
  let(:attendance_id) { attendances.first.id }

  # Test suite for GET /attendances
  describe 'GET /attendances' do
    # make HTTP get request before each example
    before { get '/attendances' }

    it 'returns attendances' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /attendances/:id
  describe 'GET /attendances/:id' do
    before { get "/attendances/#{attendance_id}" }

    context 'when the record exists' do
      it 'returns the attendance' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(attendance_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:attendance_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Attendance/)
      end
    end
  end

  # Test suite for POST /attendances
  describe 'POST /attendances' do
    # valid payload
    let(:valid_attributes) { { checkin: DateTime.now.beginning_of_day } }

    context 'when the request is valid' do
      before { post '/attendances', params: valid_attributes }

      it 'creates a attendance' do
        expect(json['checkin']).to eq(DateTime.now.beginning_of_day.utc.iso8601(3))
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/attendances', params: { checkin: nil } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Checkin can't be blank/)
      end
    end
  end

  # Test suite for PUT /attendances/:id
  describe 'PUT /attendances/:id' do
    let(:valid_attributes) { { checkin: DateTime.now } }

    context 'when the record exists' do
      before { put "/attendances/#{attendance_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /attendances/:id
  describe 'DELETE /attendances/:id' do
    before { delete "/attendances/#{attendance_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end