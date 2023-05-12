require 'rails_helper'
require 'jwt'

RSpec.describe 'POST /login', type: :request do
  describe 'POST /login' do
    before do 
      @user = User.create!(name: Faker::Name.name, password: 'password')
      @token = JWT.encode({ name: @user.name }, 'mysecret')
      @headers = { 'Authorization' => "Bearer #{@token}" }
    end

    it 'authenticates the user' do
      post '/api/v1/login', params: { name: @user.name, password: @user.password }, as: :json, headers: @headers
      expect(response).to have_http_status(:ok)
      expect(json).to eq({
        'id' => @user.id,
        'name' => @user.name,
        'role' => @user.role,
        'token' => @token
      })
    end
 
    it 'returns error when username does not exist' do
      post '/api/v1/login', params: { name: Faker::Name.name, password: '123456' }
      expect(response).to have_http_status(:not_acceptable)
    end

    it 'returns error when password does not exist' do
      post '/api/v1/login', params: { name: @user.name, password: '1234756' }, as: :json, headers: @headers 
      expect(response).to have_http_status(:not_acceptable)
    end
   end
end
