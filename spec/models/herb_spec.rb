# == Schema Information
#
# Table name: herbs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Herb do
  fixtures :herbs
  let(:herb) { herbs(:one) }
  subject { herb }
  
  it { should respond_to :name }
  it { should respond_to :products }
  
  it { should be_valid }
  
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
