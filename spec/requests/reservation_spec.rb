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
      get '/api/v1/reservations', headers: @headers, as: :json
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

    it 'Should get a specific reservation' do
      Reservation.create(id: 1, user_id: @user.id, tutor_id: @tutor.id, date: '2021-04-20')
      get '/api/v1/reservations/1', headers: @headers, as: :json
      expect(response).to have_http_status(:ok)
      expect(json).to be_a(Hash)
    end

    it 'Should update a reservation' do
      Reservation.create(id: 1, user_id: @user.id, tutor_id: @tutor.id, date: '2021-04-20')
      put '/api/v1/reservations/1', headers: @headers, as: :json, params: { date: '2023-04-25' }
      expect(response).to have_http_status(:ok)
      expect(json).to eq({ 'message' => 'Updated successfully' })
    end

    it 'Should not update a reservation' do
      Reservation.create(id: 1, user_id: @user.id, tutor_id: @tutor.id, date: '2021-04-20')
      put '/api/v1/reservations/1', headers: @headers, as: :json, params: { date: '' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json).to be_a(Hash)
      expect(json).not_to be_empty
    end

    it 'Should destroy a reservation' do
      Reservation.create(id: 1, user_id: @user.id, tutor_id: @tutor.id, date: '2021-04-20')
      delete '/api/v1/reservations/1', headers: @headers, as: :json
      expect(response).to have_http_status(:ok)
      expect(json).to eq({ 'message' => 'Deleted successfully' })
    end
  end
end
