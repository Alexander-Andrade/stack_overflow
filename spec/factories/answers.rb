FactoryGirl.define do
  sequence(:content) { |n| "#{Faker::Lorem.sentence}#{n}" }
  factory :answer do
    content
  end
end
