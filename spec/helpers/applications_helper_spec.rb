require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsHelper do
  include ActionView::Helpers
  include Haml::Helpers
  
  describe "#display_text" do
    it "should return a line" do
      @line = "One line"
      helper.display_text(@line).should == @line
    end
    
    it "should convert \n to a <br> tag" do
      @line = "One line\nAnd another."
      helper.display_text(@line).should == "One line\n<br />And another."
    end
    
    it "should convert \r\n to a <br> tag" do
      @line = "One line\r\nAnd another."
      helper.display_text(@line).should == "One line\n<br />And another."
    end
  end
end
