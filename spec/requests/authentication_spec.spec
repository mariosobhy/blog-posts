require 'rails_helper'
RSpec.describe 'POST /login', type: :request do
  let(:user) { create(:user) }
  let(:url) { '/authenticate' }
  let(:params) do
    {
      email: user.email,
      password: user.password
    }
  end

  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in response body' do
      expect(response.body['auth_token']).to be_present
    end
  end

  context 'when login params are incorrect' do
    before { post url }
    
    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end

end