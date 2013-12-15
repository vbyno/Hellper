# == Schema Information
#
# Table name: tickets
#
#  id                :integer          not null, primary key
#  ticket_subject_id :integer          not null
#  ticket_status_id  :integer          not null
#  reference         :string(255)      not null
#  body              :text             not null
#  created_at        :datetime
#  updated_at        :datetime
#  owner_id          :integer
#  customer_name     :string(255)      not null
#  customer_email    :string(255)      not null
#

require 'spec_helper'

describe Ticket do
  let(:ticket) { create :ticket }
  let(:valid_reference) { 'ABC-123-ABC-123-ABC' }
  let(:ticket_status) { create :ticket_status }
  let(:default_ticket_status) { create :ticket_status, status: TicketStatus::DEFAULT }

  it { expect(subject).to belong_to :ticket_subject }
  it { expect(subject).to belong_to :ticket_status }
  it { expect(subject).to belong_to(:owner).class_name('User') }
  it { expect(subject).to have_many :replies }
  it { expect(subject).to accept_nested_attributes_for :replies }

  it { expect(subject).to validate_presence_of :customer_name }
  it { expect(subject).to validate_presence_of :customer_email }
  it { expect(subject).to validate_presence_of :ticket_status }
  it { expect(subject).to validate_presence_of :ticket_subject }
  it { expect(subject).to validate_presence_of :body }

  it 'validates format of email' do
    expect(subject).to allow_value('email@good_email.comx').for(:customer_email)
    expect(subject).not_to allow_value('email@ with.space').for(:customer_email)
    expect(subject).not_to allow_value('email').for(:customer_email)
  end

  context 'reference' do
    it 'validates format of reference' do
      expect(subject).to allow_value(valid_reference).for(:reference)
      expect(subject).not_to allow_value('ABC-123-ABC-123-123').for(:reference)
      expect(subject).not_to allow_value('ABC').for(:reference)
    end

    it 'validates uniqueness of reference' do
      expect(build :ticket, reference: ticket.reference).not_to be_valid
    end
  end

  context 'Before Validation:' do
    it 'sets default ticket status' do
      allow(TicketStatus).to receive(:default_ticket_status).and_return default_ticket_status
      ticket = build(:ticket, ticket_status: nil)

      expect(ticket).to be_valid
      expect(ticket.ticket_status.status).to eq default_ticket_status.status
    end

    it 'does not set ticket status if status exists' do
      ticket = build(:ticket, ticket_status: ticket_status)

      expect(ticket).to be_valid
      expect(ticket.ticket_status).to eq ticket_status
      expect(ticket.ticket_status.status).not_to eq TicketStatus::DEFAULT
    end

    it 'assigns reference before validation' do
      Ticket.destroy_all
      allow(Guid).to receive(:generate_new).and_return valid_reference
      ticket = build :ticket, reference: nil

      expect(ticket).to be_valid
      expect(ticket.reference).to eq valid_reference
    end
  end
end
