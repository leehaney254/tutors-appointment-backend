require 'rails_helper'
require 'jwt'

RSpec.describe Api::V1::ReservationsController, type: :request do
  describe 'POST/create reservation' do
    it 'Should log in' do
      get api_v1_reservations_url
      expect(response).to have_http_status(401)
      expect(json).to eq({ 'message' => 'Please log in' })
    end

    before do
      @user = FactoryBot.create(:user, name: Faker::Name.name, password: 'password')
      @tutor = Tutor.create(id: '1', name: 'tutor1', image: 'image1.com', speciality: 'speciality1', bio: 'bio1',
                            price: 100)
      token = JWT.encode({ name: @user.name }, 'mysecret')
      @headers = { 'Authorization' => "Bearer #{token}" }
      @reservation_params = { user_id: @user.id, tutor_id: @tutor.id, date: '2021-04-20' }
    end

    it 'Should get an empty array' do
      get '/api/v1/reservations?user_id=1', headers: @headers, as: :json
      expect(response).to have_http_status(200)
      expect(json).to eq([])
    end

    it 'Should create a reservation' do
      post '/api/v1/reservations', headers: @headers, as: :json, params: @reservation_params
      expect(response).to have_http_status(201)
      expect(json).to eq({ 'message' => 'Created successfully' })
    end

    it 'Should not create a reservation' do
      post '/api/v1/reservations', headers: @headers, as: :json,
                                   params: { user_id: @user.id, tutor_id: @tutor.id, date: '' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json).to be_a(Hash)
      expect(json).not_to be_empty
    end
  end
end
