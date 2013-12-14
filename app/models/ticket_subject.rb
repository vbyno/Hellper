# == Schema Information
#
# Table name: ticket_subjects
#
#  id         :integer          not null, primary key
#  subject    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class TicketSubject < ActiveRecord::Base
  validates :subject, presence: true
end
