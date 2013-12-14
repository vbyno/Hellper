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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable,
  # :registerable, :validatable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable

  validates :username, presence: true, length: { minimum: 3 }, format: USERNAME_REGEXP
  validates :password, presence: true, length: { in: 6..20 }
end
