# == Schema Information
#
# Table name: replies
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  user_id    :integer          not null
#  ticket_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Reply do
  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :ticket }

  it { expect(subject).to validate_presence_of :user }
  it { expect(subject).to validate_presence_of :ticket }
  it { expect(subject).to validate_presence_of :body }
end
