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
  it { expect(subject).to validate_presence_of :name }
  it { expect(subject).to validate_presence_of :email }
  it { expect(subject).to validate_uniqueness_of :email }
end
