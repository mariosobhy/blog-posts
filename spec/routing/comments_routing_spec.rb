require "rails_helper"

RSpec.describe CommentsController, type: :routing do
  
  let(:post) { create(:post) }

  describe "routing" do
    it "routes to #index" do
      expect(:get => "posts/#{post.id}/comments").to route_to("comments#index", post_id: post.id.to_s)
    end

    it "routes to #show" do
      expect(:get => "posts/#{post.id}/comments/1").to route_to("comments#show", id: "1", post_id: post.id.to_s)
    end


    it "routes to #create" do
      expect(:post => "posts/#{post.id}/comments").to route_to("comments#create", post_id: post.id.to_s)
    end

    it "routes to #update via PUT" do
      expect(:put => "posts/#{post.id}/comments/1").to route_to("comments#update", id: "1", post_id: post.id.to_s)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "posts/#{post.id}/comments/1").to route_to("comments#update", id: "1", post_id: post.id.to_s)
    end

    it "routes to #destroy" do
      expect(:delete => "posts/#{post.id}/comments/1").to route_to("comments#destroy", id: "1", post_id: post.id.to_s)
    end
  end
end
