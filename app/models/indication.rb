# == Schema Information
#
# Table name: indications
#
#  id         :integer          not null, primary key
#  herb_id    :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Indication < ActiveRecord::Base
  belongs_to :herb
  
  validates_length_of :name, minimum: 1, maximum: 256
  
  attr_accessible :name
end
