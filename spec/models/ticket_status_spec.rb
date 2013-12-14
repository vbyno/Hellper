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
end
