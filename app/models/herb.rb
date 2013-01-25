# == Schema Information
#
# Table name: herbs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Herb < ActiveRecord::Base
  attr_accessible :name
  
  has_and_belongs_to_many :products
  
  validates :name, presence: true
  validates_length_of :name, maximum: 256
  
end