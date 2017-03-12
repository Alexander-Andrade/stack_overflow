FactoryGirl.define do
  factory :question do
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.sentences.join }
  end
end
