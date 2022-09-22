FactoryBot.define do
  factory :user do
    sequence(:name) do |n|
      "user#{n}"
    end
    password {'password'}
  end
end
