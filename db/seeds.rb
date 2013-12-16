require 'database_cleaner'

namespace :db do
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean

  ticket_subjects = [
    'Pipeline Broken',
    'Bootstrap does not Suit',
    'Migration Failed'].map do |subject|
    TicketSubject.create!(subject: subject)
  end

  ticket_statuses = [
    'Waiting for Staff Response',
    'Waiting for Customer',
    'On Hold',
    'Cancelled',
    'Completed'
  ].map do |status|
   TicketStatus.create!(status: status)
  end

  staff = %w[jack bob alan].map do |username|
    User.create!(username: username, password: 'hellper')
  end

  ticket_statuses_count = ticket_statuses.count
  ticket_subjects_count = ticket_subjects.count

  (1..100).each do |i|
    Ticket.create!(
      ticket_status: ticket_statuses[i % ticket_statuses_count],
      ticket_subject: ticket_subjects[i % ticket_subjects_count],
      owner: i.even? ? staff.sample : nil,
      customer_name: "John Smith ##{i}",
      customer_email: "customer@email_#{i}.comx",
      body: 'Some text. It should be very long text. Much longer.'
    )
  end
end