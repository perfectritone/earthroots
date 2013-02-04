class Book < ActiveRecord::Base
  attr_accessible :author, :year, :title, :page, :general
  
  has_many :herb_resources
  has_many :herbs, through: :herb_resources
  
  def to_s
    s = ""
    s += "#{self.author}. " if self.author.present?
    s += "#{self.year}. " if self.year.present?
    s += "#{self.title}. " if self.title.present?
    s += "Page #{self.page}." if self.page.present?
    s
  end
end
