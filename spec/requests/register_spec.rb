require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /register' do
    it 'authenticates the user' do
      user_name = Faker::Name.name
      post '/api/v1/users', params: { user: { name: user_name, password: 'password' } }
      expect(response).to have_http_status(:created)
      expect(json).to eq({
        'message' => "#{user_name} created successfully"
      })
    end

    it 'returns error when username does not exist' do
      post '/api/v1/users', params: { user: { name: '', password: 'password' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json).to eq({
                           'name' => ["can't be blank"]
                         })
    end

    it 'returns error when password does not exist' do
      post '/api/v1/users', params: { user: { name: Faker::Name.name, password: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json).to eq({
                           'password' => ["can't be blank"]
                         })
    end
  end
end
