require File.dirname(__FILE__) + '/../spec_helper'

describe ProductSize do
  fixtures :product_sizes, :products, :users
  let(:product_size) {product_sizes(:one)}
  subject { product_size }
  
  it { should respond_to :size }
  it { should respond_to :price }
  it { should respond_to :product }
  
  it { should be_valid }
  
  describe "price validations" do
    it "should be valid without decimal" do
      product_size.price = 9
      should be_valid
    end
    
    it "should be valid with one number to right of decimal" do
      product_size.price = 9.9
      should be_valid
    end
    
    it "should be invalid with too many digits to right of decimal" do
      product_size.price = 9.999
      should_not be_valid
    end
    
    it "should be valid" do
      product_size.price = 9.99
      should be_valid
    end
    
  end
    
end
