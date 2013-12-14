# == Schema Information
#
# Table name: tickets
#
#  id                :integer          not null, primary key
#  customer_id       :integer          not null
#  ticket_subject_id :integer          not null
#  ticket_status_id  :integer          not null
#  reference         :string(255)      not null
#  body              :text             not null
#  created_at        :datetime
#  updated_at        :datetime
#  owner_id          :integer          not null
#

require 'spec_helper'

describe Ticket do
  let(:ticket) { create :ticket }
  let(:valid_reference) { 'ABC-123-ABC-123-ABC' }

  it { expect(subject).to belong_to :ticket_subject }
  it { expect(subject).to belong_to :ticket_status }
  it { expect(subject).to belong_to :customer }
  it { expect(subject).to belong_to(:owner).class_name('User') }

  it { expect(subject).to validate_presence_of :customer }
  it { expect(subject).to validate_presence_of :ticket_status }
  it { expect(subject).to validate_presence_of :ticket_subject }
  it { expect(subject).to validate_presence_of :body }
  it { expect(subject).to validate_presence_of :owner }

  context 'reference' do
    it 'assigns reference before validation' do
      ticket = build :ticket, reference: nil

      expect(ticket).to be_valid
      expect(ticket.reference).not_to be_nil
    end

    it 'validates format of reference' do
      expect(subject).to allow_value(valid_reference).for(:reference)
      expect(subject).not_to allow_value('ABC-123-ABC-123-123').for(:reference)
      expect(subject).not_to allow_value('ABC').for(:reference)
    end

    it 'validates uniqueness of reference' do
      expect(build :ticket, reference: ticket.reference).not_to be_valid
    end
  end

  describe '#set_unique_reference' do
    before :all do
      Ticket.destroy_all
    end

    it 'sets unique reference' do
      allow(Guid).to receive(:generate_new).and_return valid_reference
      ticket.reference = nil
      expect(ticket.set_unique_reference).to eq valid_reference
    end

    xit 'sets unique reference if reference has already been taken' do
      #TODO
    end
  end
end
