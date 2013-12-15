FactoryGirl.define do
  factory :ticket_status do
    sequence(:status) { |n| "Ticket Status #{n}" }
  end

  factory :ticket_subject do
    sequence(:subject) { |n| "Ticket Subject #{n}" }
  end

  factory :ticket do
    association :ticket_status
    association :ticket_subject
    association :owner, factory: :user
    customer_name 'John Smith'
    customer_email 'customer@email.comx'
    body 'Ticket Body'
    sequence(:reference) { |n| "ABC-123-ABC-#{100+n}-ABC" }
  end

  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    password 'password'
  end
end