# == Schema Information
#
# Table name: staff
#
#  id                  :integer          not null, primary key
#  username            :string(255)      default(""), not null
#  encrypted_password  :string(255)      default(""), not null
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string(255)
#  last_sign_in_ip     :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

require 'spec_helper'

describe User do
  it { expect(subject).to validate_presence_of :username }
  it { expect(subject).to validate_presence_of :password }
  it { expect(subject).to ensure_length_of(:username).is_at_least(3) }
  it { expect(subject).to ensure_length_of(:password).is_at_least(6).is_at_most(20) }

  it 'validates format of username' do
    expect(subject).to allow_value('valid_userName1').for(:username)
    expect(subject).not_to allow_value('with space').for(:username)
  end
end
