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
  let(:ticket) { create :ticket }

  it { expect(subject).to belong_to :ticket_subject }
  it { expect(subject).to belong_to :ticket_status }
  it { expect(subject).to belong_to :customer }

  it { expect(subject).to validate_presence_of :body }

  context 'reference' do
    before :all do
      Ticket.destroy_all
    end

    it { expect(subject).to validate_presence_of :reference }

    it 'validates format og reference' do
      expect(subject).to allow_value('ABC-123-ABC-123-ABC').for(:reference)
      expect(subject).not_to allow_value('ABC-123-ABC-123-123').for(:reference)
      expect(subject).not_to allow_value('ABC').for(:reference)
    end

    it 'validates uniqueness of reference' do
      expect(build :ticket, reference: ticket.reference).not_to be_valid
    end
  end
end
