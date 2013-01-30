# == Schema Information
#
# Table name: herbs
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  family            :string(255)
#  genus             :string(255)
#  species           :string(255)
#  description       :text
#  harvest           :text
#  constituents      :text
#  traditional_uses  :text
#  overview          :text
#  safety            :text
#  dosage            :text
#  other_information :text
#  resources         :text
#

class Herb < ActiveRecord::Base
  attr_accessible :name, :family, :genus, :species, :description, :harvest,
    :constituents, :traditional_uses, :overview, :safety, :dosage, :parts_used,
    :other_information, :resources, :common_names_attributes,
    :actions_attributes, :indications_attributes
  
  has_and_belongs_to_many :products
  has_many :common_names
  has_many :actions
  has_many :indications
  
  accepts_nested_attributes_for :common_names, allow_destroy: true,
    reject_if: lambda { |a| a[:name].blank? }
  accepts_nested_attributes_for :actions, allow_destroy: true,
    reject_if: lambda { |a| a[:name].blank? }
  accepts_nested_attributes_for :indications, allow_destroy: true,
    reject_if: lambda { |a| a[:name].blank? }
  
  #validates :name, presence: true
  validates_length_of :name, minimum: 1, maximum: 256
  validates_length_of :family, minimum: 1, maximum: 256
  validates_length_of :genus, minimum: 1, maximum: 256
  validates_length_of :species, minimum: 1, maximum: 256
  
  def self.names
    self.select(:name).map { |h| h.name }
  end
  
end
