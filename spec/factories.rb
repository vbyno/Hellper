FactoryGirl.define do
  factory :ticket_status do
    sequence(:status) { |n| "Ticket Status #{n}" }
  end

  factory :ticket_subject do
    sequence(:subject) { |n| "Ticket Subject #{n}" }
  end

  factory :customer do
    sequence(:email) { |n| "customer_#{n}@email.comx" }
    name 'John Smith'
  end

  factory :ticket do
    association :ticket_status
    association :ticket_subject
    association :customer
    association :owner, factory: :user
    body 'Ticket Body'
    sequence(:reference) { |n| "ABC-123-ABC-#{100+n}-ABC" }
  end

  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    password 'password'
  end
end