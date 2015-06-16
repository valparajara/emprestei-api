FactoryGirl.define do
  factory :user do

    sequence(:email) { |n| "teste#{n}@email.com" }
    password '12345678'

    trait :access_token do
      access_token { SecureRandom.hex }
    end

    trait :with_loans do
      transient do
        loans_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:loan, evaluator.loans_count, user: user)
      end
    end
  end
end
