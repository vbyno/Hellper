# == Schema Information
#
# Table name: ticket_statuses
#
#  id         :integer          not null, primary key
#  status     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class TicketStatus < ActiveRecord::Base
  validates :status, presence: true
end
