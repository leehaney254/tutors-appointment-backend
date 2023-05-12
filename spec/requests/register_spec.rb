require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /register' do
    it 'authenticates the user' do
      post 'http://127.0.0.1:3000//api/v1/users', params: {user: {name: 'user1', password: 'password'}}
      expect(response).to have_http_status(:created)
      expect(json).to eq({
        "message" => "user1 created successfully"
      })
    end

    it 'returns error when username does not exist' do
      post 'http://127.0.0.1:3000//api/v1/users', params: {user: {name: '', password: 'password'}}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json).to eq({
        "name" => ["can't be blank"]
      })
      end  

    it 'returns error when password does not exist' do  
      post 'http://127.0.0.1.3000//api/v1/users', params: {user: {name: 'user1', password: ''}}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json).to eq({
        "password" => ["can't be blank"]
      })
      end 
      
  end
end