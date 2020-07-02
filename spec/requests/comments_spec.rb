require 'rails_helper'

RSpec.describe "Comments", type: :request do
  # initialize test data 
  let(:user) { create(:user) }
  let(:url) { '/authenticate' }
  let(:params) do
    {
      email: user.email,
      password: user.password
    }
  end
  before do
    post url, params: params
  end
  let(:token) { response.body }
   
  # Initialize the test data
  let!(:post_item) { create(:post) }
  let!(:comments) { create_list(:comment, 20) }
  let(:post_id) { post_item.id }
  let(:id) { comments.first.id }

    describe 'GET /posts/:post_id/comments' do
      before { get "/posts/#{post_id}/comments", params: {}, headers: { 'Authorization': JSON.parse(token)['auth_token'] } }
  
      context 'when post exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
  
        it 'returns all post comments' do
          expect(json.size).to eq(20)
        end
      end
  
      context 'when post does not exist' do
        let(:post_id) { 0 }
  
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
  
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find post/)
        end
      end
    end
  
    # Test suite for GET /posts/:post_id/comments/:id
    describe 'GET /posts/:post_id/comments/:id' do
      before { get "/posts/#{post_id}/comments/#{id}", params: {}, headers: { 'Authorization': JSON.parse(token)['auth_token'] } }
  
      context 'when post comment exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
  
        it 'returns the comment' do
          expect(json['id']).to eq(id)
        end
      end
  
      context 'when post comment does not exist' do
        let(:id) { 0 }
  
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
  
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find comment/)
        end
      end
    end
  
    # Test suite for PUT /posts/:post_id/comments
    describe 'POST /posts/:post_id/comments' do
      let(:valid_attributes) { { latitude: 30.2156, longitude: 31.562 } }
  
      context 'when request attributes are valid' do
        before { post "/posts/#{post_id}/comments", params: valid_attributes, headers: { 'Authorization': JSON.parse(token)['auth_token'] } }
  
        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end
  
      context 'when an invalid request' do
        before { post "/posts/#{post_id}/comments", params: {}, headers: { 'Authorization': JSON.parse(token)['auth_token'] } }
  
        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
  
      end
    end
  
    # Test suite for PUT /posts/:post_id/comments/:id
    describe 'PUT /posts/:post_id/comments/:id' do
      let(:valid_attributes) { { latitude: 30.6656 } }
  
      before { put "/posts/#{post_id}/comments/#{id}", params: valid_attributes, headers: { 'Authorization': JSON.parse(token)['auth_token'] } }
  
      context 'when comment exists' do
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
  
        it 'updates the comment' do
          updated_comment = comment.find(id)
          expect(updated_comment.latitude).to eq(30.6656)
        end
      end
  
      context 'when the comment does not exist' do
        let(:id) { 0 }
  
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
  
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find comment/)
        end
      end
    end
  
    # Test suite for DELETE /posts/:id
    describe 'DELETE /posts/:id' do
      before { delete "/posts/#{post_id}/comments/#{id}", headers: { 'Authorization': JSON.parse(token)['auth_token'] } }
  
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
end
