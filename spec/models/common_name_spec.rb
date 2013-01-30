# == Schema Information
#
# Table name: common_names
#
#  id         :integer          not null, primary key
#  herb_id    :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require File.dirname(__FILE__) + '/../spec_helper'

describe CommonName do
  fixtures :common_names
  let(:common_name) { common_names(:one) }
  subject { common_name }
  
  it { should respond_to :name }
  
  #parent
  it { should respond_to :herb }
 
  it { should be_valid }
  
  describe "name" do
    it "should be invalid with blank name" do
      common_name.name = ""
      common_name.should_not be_valid
    end
    
    it "should be invalid with nil name" do
      common_name.name = nil
      common_name.should_not be_valid
    end
    
    it "should be invalid with long name" do
      common_name.name = "a"*257
      common_name.should_not be_valid
    end
  end
end
