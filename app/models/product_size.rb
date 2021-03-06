# == Schema Information
#
# Table name: product_sizes
#
#  id         :integer          not null, primary key
#  product_id :integer
#  size       :string(255)
#  price      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductSize < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  attr_accessible :product_id, :size, :price
  
  belongs_to :product
  
  validates_presence_of :size, :price
  validates_length_of :size, maximum: 256
  validates :price, 
    format: { with: /^\d+??(?:\.\d{0,2})?$/ }, 
    numericality: { greater_than: 0 }
    
  def display_price
    number_to_currency(self.price)
  end
end
