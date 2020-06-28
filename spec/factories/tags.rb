# spec/factories/tags.rb
FactoryBot.define do
    factory :tag do
      name { Faker::StarWars.character }
      post_id nil
    end
  end