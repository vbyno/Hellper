require 'database_cleaner'

namespace :db do
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean

  ['Pipeline Broken', 'Bootstrap does not Suit', 'Migration Failed'].each do |subject|
    TicketSubject.create!(subject: subject)
  end

  TicketStatus.create!(status: TicketStatus::DEFAULT)
  User.create!(username: 'vbyno', password: 'hellper')
end