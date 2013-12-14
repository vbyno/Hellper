# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  email      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Customer do
  let(:customer) { create :customer }

  it { expect(subject).to validate_presence_of :name }
  it { expect(subject).to validate_presence_of :email }

  it 'validates uniquness of email' do
    expect(build :customer, email: customer.email).not_to be_valid
  end
end
