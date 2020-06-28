FactoryBot.define do
    factory :post do
      association :author, factory: :user
      title { Faker::Lorem.word }
      body { Faker::Lorem.word }
    end
end