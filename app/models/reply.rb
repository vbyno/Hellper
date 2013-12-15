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

class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket

  scope :existing_in_desc, -> { where.not(id: nil)
                                  .order('created_at DESC')
                                  .includes(:user) }

  validates :user, :ticket, :body, presence: true
end
