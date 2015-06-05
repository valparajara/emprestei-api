FactoryGirl.define do
  factory :loan do

    sequence(:email) { |n| "teste#{n}@email.com" }
    item_lent 'Livro Emprestado'

    trait :returned do
      returned true
    end

  end
end
