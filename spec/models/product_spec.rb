# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  category    :string(255)
#  picture_url :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Product do
  fixtures :products
  let(:product) { products(:one) }
  subject { product }
  
  it { should respond_to :name }
  it { should respond_to :category }
  it { should respond_to :description }
  it { should respond_to :picture_url }
  it { should respond_to :herbs }
  it { should respond_to :product_sizes }
  
  it { should be_valid }
  
  it "should be invalid with blank name" do
    product.name = ""
    product.should_not be_valid
  end
  
  it "should be invalid with nil name" do
    product.name = nil
    product.should_not be_valid
  end
  
  it "should be invalid with long name" do
    product.name = "a"*257
    product.should_not be_valid
  end
  
  it "should be invalid with long category" do
    product.category = "a"*257
    product.should_not be_valid
  end
  
  it "should be invalid with long picture url" do
    product.picture_url = "a"*257
    product.should_not be_valid
  end
  
  it "should convert address to lowercase" do
    mixed_case_address = "www.GoogLe.COm"
    product.picture_url = mixed_case_address
    product.save
    product.picture_url.should == mixed_case_address.downcase
  end
  
  it "should be invalid when the picture_url is malformed " do
    product.picture_url = "no_tld"
    should_not be_valid
  end
end
