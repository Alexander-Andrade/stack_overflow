FactoryGirl.define do
  factory :question do
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.sentences.join }
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
