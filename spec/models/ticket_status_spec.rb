# == Schema Information
#
# Table name: ticket_statuses
#
#  id         :integer          not null, primary key
#  status     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe TicketStatus do
  it { expect(subject).to validate_presence_of :status }
  it { expect(subject).to validate_uniqueness_of :status }

  describe '.default_ticket_status' do
    let!(:default_ticket_status) { create :ticket_status, status: TicketStatus::DEFAULT}

    it 'finds default ticket status' do
      expect(TicketStatus.default_ticket_status).to eq default_ticket_status
    end
  end
end
