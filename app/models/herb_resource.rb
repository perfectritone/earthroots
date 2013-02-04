class HerbResource < ActiveRecord::Base
  attr_accessible :book_id, :herb_id, :link_id
  
  belongs_to :link
  belongs_to :book
end
