# spec/factories/comments.rb
FactoryBot.define do
    factory :comment do
      text { Faker::Lorem.word }
      association :commenter, factory: :user
      post
    end
  end