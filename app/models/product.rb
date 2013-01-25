# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  category    :string(255)
#  picture_url :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class Product < ActiveRecord::Base
  require 'uri'
  attr_accessible :name, :category, :description, :picture_url
  
  has_and_belongs_to_many :herbs
  has_many :product_sizes
  
  CATEGORIES = ["salves"]
  
  before_validation :downcase_url
  validate :valid_url, unless: "picture_url.blank?"
  validates :name, presence: true
  validates_length_of :name, maximum: 256
  validates_length_of :picture_url, maximum: 256
  validates_inclusion_of :category, in: CATEGORIES, allow_blank: true
  
  private
    def downcase_url
      self.picture_url.strip!
      self.picture_url.downcase!
    rescue
      self.picture_url = nil
    end
    
    def valid_url
      errors.add(:picture_url, 'not valid') if (self.picture_url =~ URI::regexp).nil?
    end
end