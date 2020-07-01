FactoryBot.define do
    factory :post do
      association :author, factory: :user
      title { Faker::Lorem.word }
      body { Faker::Lorem.word }
      before :create do |post|
        post.tags = build_list :tag, 2, post: post
      end
    end
end