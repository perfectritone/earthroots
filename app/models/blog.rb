# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Blog < ActiveRecord::Base
  attr_accessible :title, :content
  
  validates_presence_of :title, :content
  validates_length_of :title, maximum: 256
  
  default_scope order: "blogs.created_at DESC"
end
