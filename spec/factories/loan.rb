FactoryGirl.define do
  factory :loan do

    sequence(:email) { |n| "teste#{n}@email.com" }
    loaned_item 'Livro Emprestado'

    trait :returned do
      returned true
    end

  end
end
