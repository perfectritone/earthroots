# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  category   :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  general    :boolean          default(TRUE)
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Link do
  fixtures :links
  let!(:link) { links(:one)}
  subject { link }
  
  it { should respond_to :address}
  it { should respond_to :name}
  it { should respond_to :category}
  
  it { should be_valid }
  
  describe "should be invalid when address is not standard" do
    it "nil" do
      link.address = nil
      should_not be_valid
    end
    it "empty string" do
      link.address = ""
      should_not be_valid
    end
    it "white space string" do
      link.address = "      "
      should_not be_valid
    end
    it "no tld" do
      link.address = "no_tld"
      should_not be_valid
    end
  end
  
  it "should convert address to lowercase" do
    mixed_case_address = "www.GoogLe.COm"
    link.address = mixed_case_address
    link.save
    link.address.should == mixed_case_address.downcase
  end
  
  it "should be invalid when url is longer than 256 chars" do
    link.address = "a"*257
    should_not be_valid
  end
  
  it "should be invalid when name is longer than 256 chars" do
    link.name = "a"*257
    should_not be_valid
  end
  
  it "should be invalid when url is blank" do
    link.address = ""
    should_not be_valid
  end
  
  it "should be invalid when name is blank" do
    link.name = ""
    should_not be_valid
  end
  
  it "should be invalid when category is not in category list" do
    link.category = "something else"
    should_not be_valid
  end
end
