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

class Customer < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :email, uniqueness: true #TODO email regexp
end
