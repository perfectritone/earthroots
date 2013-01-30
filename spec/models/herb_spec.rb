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

require File.dirname(__FILE__) + '/../spec_helper'

describe Herb do
  fixtures :herbs
  let(:herb) { herbs(:one) }
  subject { herb }
  
  it { should respond_to :name }
  it { should respond_to :family }
  it { should respond_to :genus }
  it { should respond_to :species }
  it { should respond_to :description }
  it { should respond_to :harvest }
  it { should respond_to :constituents }
  it { should respond_to :traditional_uses }
  it { should respond_to :overview }
  it { should respond_to :safety }
  it { should respond_to :dosage }
  it { should respond_to :other_information }
  it { should respond_to :resources }
  
  #has_many association
  it { should respond_to :products }
  
  #children
  it { should respond_to :common_names }
  it { should respond_to :actions }
  it { should respond_to :indications }
  
  it { should be_valid }
  
  describe "name" do
    it "should be invalid with blank name" do
      herb.name = ""
      herb.should_not be_valid
    end
    
    it "should be invalid with nil name" do
      herb.name = nil
      herb.should_not be_valid
    end
    
    it "should be invalid with long name" do
      herb.name = "a"*257
      herb.should_not be_valid
    end
  end
  
  describe "family" do
    it "should be invalid with blank family" do
      herb.family = ""
      herb.should_not be_valid
    end
    
    it "should be invalid with nil family" do
      herb.family = nil
      herb.should_not be_valid
    end
    
    it "should be invalid with long family" do
      herb.family = "a"*257
      herb.should_not be_valid
    end
  end
  
  describe "genus" do
    it "should be invalid with blank genus" do
      herb.genus = ""
      herb.should_not be_valid
    end
    
    it "should be invalid with nil genus" do
      herb.genus = nil
      herb.should_not be_valid
    end
    
    it "should be invalid with long genus" do
      herb.genus = "a"*257
      herb.should_not be_valid
    end
  end
  
  describe "species" do
    it "should be invalid with blank species" do
      herb.species = ""
      herb.should_not be_valid
    end
    
    it "should be invalid with nil species" do
      herb.species = nil
      herb.should_not be_valid
    end
    
    it "should be invalid with long species" do
      herb.species = "a"*257
      herb.should_not be_valid
    end
  end
end
