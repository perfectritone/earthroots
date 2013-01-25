class ProductSize < ActiveRecord::Base
  attr_accessible :product_id, :size, :price
  
  belongs_to :product
  
  validates_presence_of :size, :price
  validates_length_of :size, maximum: 256
  validates :price, 
    format: { with: /^\d+??(?:\.\d{0,2})?$/ }, 
    numericality: { greater_than: 0 }
  
  private
    def currency
      errors.add(:price, 'not valid') if (self.price.to_s =~ /\d+(\.\d\d?)?/).nil?
    end
end