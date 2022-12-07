require 'rails_helper'

RSpec.describe 'FitnessActivities', type: :request do
  describe 'GET #index' do
    before(:example) do
      @user = User.create!(name: 'test', email: 'test@test.com', admin: true, password: 'password')
      @fitness_activity = FitnessActivity.create(name: 'Swimming', description: 'Swimming is a the act of moving through water using the limbs.', amount: 1)

      post '/api/v1/auth', params: { email: @user.email, password: @user.password }
      @token = JSON.parse(response.body)['token']

      get '/api/v1/fitness_activities', headers: { Authorization: "Bearer #{@token}" }
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of fitness activities' do
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'returns a list of fitness activities with the correct attributes' do
      expect(JSON.parse(response.body)['data'][0]['attributes']).to include('name' => 'Swimming', 'description' => 'Swimming is a the act of moving through water using the limbs.', 'amount' => 1)
    end

    context 'authentication' do
      it 'returns a 401 if no token is provided' do
        get '/api/v1/fitness_activities'
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns a 401 if an invalid token is provided' do
        get '/api/v1/fitness_activities', headers: { Authorization: 'Bearer invalidtoken' }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
