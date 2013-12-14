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
  DEFAULT = 'Waiting for Staff Response'

  validates :status, presence: true, uniqueness: true

  def self.default_ticket_status
    find_by(status: DEFAULT)
  end
end
