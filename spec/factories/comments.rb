# spec/factories/comments.rb
FactoryBot.define do
    factory :comment do
      text { Faker::Lorem.word }
      commenter_id nil
      post_id nil
    end
  end