FactoryGirl.define do
  factory :loan do

    sequence(:friend_email) { |n| "teste#{n}@email.com" }
    friend_name 'Nome do Amigo'
    loaned_item 'Livro Emprestado'
    notification 1

    trait :returned do
      returned true
    end

  end
end
