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

class Ticket < ActiveRecord::Base
  belongs_to :ticket_subject
  belongs_to :customer
  belongs_to :ticket_status
  belongs_to :owner, class_name: User

  before_validation :set_unique_reference

  validates :body, :owner, :customer, :ticket_subject, :ticket_status, presence: true
  validates :reference,
            presence: true,
            uniqueness: true,
            format: { with: TICKET_REFERENCE_REGEXP }

  def set_unique_reference
    return if self.reference.present?

    reference = Guid.generate_new

    if self.class.where(reference: reference).any?
      set_unique_reference
    else
      self.reference = reference
    end
  end
end
