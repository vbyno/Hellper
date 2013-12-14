# == Schema Information
#
# Table name: tickets
#
#  id                :integer          not null, primary key
#  customer_id       :integer
#  ticket_subject_id :integer
#  ticket_status_id  :integer
#  reference         :string(255)      not null
#  body              :text             not null
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Ticket do
  it { expect(subject).to belong_to :ticket_subject }
  it { expect(subject).to belong_to :ticket_status }
  it { expect(subject).to belong_to :customer }

  it { expect(subject).to validate_presence_of :body }
  it { expect(subject).to validate_presence_of :reference }
end
