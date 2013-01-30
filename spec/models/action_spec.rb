# == Schema Information
#
# Table name: actions
#
#  id         :integer          not null, primary key
#  herb_id    :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Action do
  fixtures :actions
  let(:action) { actions(:one) }
  subject { action }
  
  it { should respond_to :name }
  
  #parent
  it { should respond_to :herb }
 
  it { should be_valid }
  
  describe "name" do
    it "should be invalid with blank name" do
      action.name = ""
      action.should_not be_valid
    end
    
    it "should be invalid with nil name" do
      action.name = nil
      action.should_not be_valid
    end
    
    it "should be invalid with long name" do
      action.name = "a"*257
      action.should_not be_valid
    end
  end
end
