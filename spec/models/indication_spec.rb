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

require File.dirname(__FILE__) + '/../spec_helper'

describe Indication do
  fixtures :indications
  let(:indication) { indications(:one) }
  subject { indication }
  
  it { should respond_to :name }
  
  #parent
  it { should respond_to :herb }
 
  it { should be_valid }
  
  describe "name" do
    it "should be invalid with blank name" do
      indication.name = ""
      indication.should_not be_valid
    end
    
    it "should be invalid with nil name" do
      indication.name = nil
      indication.should_not be_valid
    end
    
    it "should be invalid with long name" do
      indication.name = "a"*257
      indication.should_not be_valid
    end
  end
end
