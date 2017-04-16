FactoryGirl.define do
  sequence(:title) { |n| "#{Faker::Lorem.sentence}#{n}" }
  sequence(:body) { |n| "#{Faker::Lorem.sentences.join}#{n}" }
  factory :question do
    title
    body
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
