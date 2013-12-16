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

class Ticket < ActiveRecord::Base
  belongs_to :ticket_subject
  belongs_to :ticket_status
  belongs_to :owner, class_name: User
  has_many :replies
  accepts_nested_attributes_for :replies

  delegate :status, to: :ticket_status, prefix: false
  delegate :subject, to: :ticket_subject, prefix: false

  scope :search_by_status, ->(ticket_status_id) {
    where(ticket_status_id: ticket_status_id)
  }
  scope :search_by_subject, ->(ticket_subject_id) {
    where(ticket_subject_id: ticket_subject_id)
  }
  scope :search_by_reference, ->(reference_query) {
    where("reference LIKE ?", "%#{reference_query.upcase}%")
  }
  scope :search_by_body, ->(body_query) {
    where("lower(body) LIKE ?", "%#{body_query.downcase}%")
  }

  before_validation :set_unique_reference
  before_validation :set_ticket_status

  validates :body, :ticket_subject, :ticket_status, :customer_name, presence: true
  validates :reference,
            presence: true,
            uniqueness: true,
            format: { with: TICKET_REFERENCE_REGEXP }
  validates :customer_email, presence: true, format: { with: Devise.email_regexp }

private
  def set_unique_reference
    return if self.reference.present?
    reference = Guid.generate_new

    if self.class.where(reference: reference).any?
      set_unique_reference
    else
      self.reference = reference
    end
  end

  def set_ticket_status
    return if self.ticket_status
    self.ticket_status = TicketStatus.default_ticket_status
  end
end
