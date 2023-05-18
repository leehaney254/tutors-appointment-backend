require 'rails_helper'
require 'jwt'

RSpec.describe Api::V1::TutorsController, type: :request do
  describe 'POST/create tutor' do
    it 'Should log in' do
      get '/api/v1/tutors'
      expect(response).to have_http_status(401)
      expect(json).to eq({ 'message' => 'Please log in' })
    end

    before do
      user = FactoryBot.create(:user, name: Faker::Name.name, password: 'password')
      token = JWT.encode({ name: user.name }, 'mysecret')
      @headers = { 'Authorization' => "Bearer #{token}" }
      @tutor_params = { name: 'tutor1', image: 'image1.com', speciality: 'speciality1', bio: 'bio1', price: 100 }
    end

    it 'Should get an empty array' do
      get '/api/v1/tutors', headers: @headers, as: :json
      expect(response).to have_http_status(200)
      expect(json).to eq({ 'message' => 'There are no tutors!' })
    end

    it 'Should create a tutor' do
      post '/api/v1/tutors', headers: @headers, as: :json, params: @tutor_params
      expect(response).to have_http_status(201)
      expect(json).to eq({ 'message' => 'Created successfully' })
    end

    it 'Should not create a tutor' do
      post '/api/v1/tutors', headers: @headers, as: :json,
                             params: { name: '', image: 'image1.com', speciality: 'speciality1', bio: 'bio1' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json).to be_a(Hash)
      expect(json).not_to be_empty
    end

    it 'Should get a specific tutor' do
      Tutor.create(id: '1', name: Faker::Name.name, image: 'image1.com', speciality: 'speciality1', bio: 'bio1',
                   price: 100)
      get '/api/v1/tutors/1', headers: @headers, as: :json
      expect(response).to have_http_status(:ok)
      expect(json).to be_a(Hash)
    end

    it 'Should not update a tutor' do
      Tutor.create(id: '1', name: Faker::Name.name, image: 'image1.com', speciality: 'speciality1', bio: 'bio1',
                   price: 100)
      put '/api/v1/tutors/1', headers: @headers, as: :json, params: { speciality: '' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json).to be_a(Hash)
      expect(json).not_to be_empty
    end
  end
end
