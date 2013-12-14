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

class Ticket < ActiveRecord::Base
  belongs_to :ticket_subject
  belongs_to :customer
  belongs_to :ticket_status

  validates :reference, :body, presence: true
  # TODO validate format of reference
end