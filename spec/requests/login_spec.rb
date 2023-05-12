require 'rails_helper'

RSpec.describe 'POST /login', type: :request do
  describe 'POST /login' do
    let(:user) { FactoryBot.create(:user, name: 'user1', password: 'password') }
    token = 'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoidXNlcjEifQ.xrAjPPPwe8aoSy0Ra8cwLYbPkO2N9AiGMDID_QG7nWM'
    it 'authenticates the user' do
      post 'http://127.0.0.1:3000//api/v1/login', params: { name: user.name, password: user.password},as: :json, headers: {:Authorization => token}
      expect(response).to have_http_status(:ok)
      expect(json).to eq({
        "id" => user.id,
        "name" => user.name,
        "role" => user.role,
        'token' => token
      })
    end 

    it 'returns error when username does not exist' do
      post 'http://127.0.0.1:3000//api/v1/login', params: { name: 'user2', password: '123456' }
      expect(response).to have_http_status(:not_acceptable)
    end

    it 'returns error when password does not exist' do
      post 'http://127.0.0.1:3000//api/v1/login', params: { name: user.name, password: '123456' },as: :json, headers: {:Authorization => token}
      expect(response).to have_http_status(:not_acceptable)
    end 

  end
end
