# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  category   :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Link < ActiveRecord::Base
  require 'uri'
  
  attr_accessible :address, :category, :name
  CATEGORIES = ["herbs"]
  
  before_validation :downcase_address
  validate :valid_url
  validates :name, :address, :category, presence: true
  validates :name, :address, length: { maximum: 256 }
  validates_inclusion_of :category, in: CATEGORIES
  
  private
    def downcase_address
      self.address.downcase!
    rescue
      self.address = nil
    end
    
    def valid_url
      errors.add(:address, 'not valid') if (address =~ URI::regexp).nil?
    end
end
