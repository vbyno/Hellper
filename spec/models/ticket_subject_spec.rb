# == Schema Information
#
# Table name: ticket_subjects
#
#  id         :integer          not null, primary key
#  subject    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe TicketSubject do
  it { expect(subject).to validate_presence_of :subject }
end
