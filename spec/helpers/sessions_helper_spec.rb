require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsHelper do
  include ActionView::Helpers
  include Haml::Helpers
  fixtures :users
  let!(:user) { FactoryGirl.create(:user) }

  it "#sign_in" do
    helper.stubs(:cookies => cookies = mock)
    helper.cookies.stubs(:permanent).returns(Object.new)

    # Is this expectation enough to know the method succeeded?
    helper.cookies.permanent.expects(:[]=).with(:remember_token, user.remember_token)
    
    helper.sign_in user
    helper.current_user.should == user
    #helper.cookies[:remember_token].should == user.remember_token
  end
  
  it "#sign_out" do
    helper.stubs(:cookies).returns(cookies)
    helper.cookies.expects(:delete).with(:remember_token)
    
    helper.sign_out
    helper.current_user.should be_nil
  end

  describe "#signed_in?" do
    it "user is not signed in" do
      assign(:current_user, nil)
      helper.signed_in?.should == false
    end
    it "user is signed in" do
      assign(:current_user, user)
      helper.signed_in?.should == true
    end
  end
  
  it "#current_user=" do
    assign(:current_user, users(:dave))
    helper.current_user.should == users(:dave)
  end
  
  describe "#current_user" do
    it "user is nil, no remember_token" do
      helper.current_user.should be_nil
    end
    it "user is nil, but cookie has remember_token" do
      token = user.remember_token
      helper.stubs(:cookies => cookies = mock)
      helper.cookies.stubs(:[]).with(:remember_token).returns(token)
      helper.current_user.should == user      
    end
    it "user is signed in" do
      assign(:current_user, user)
      helper.current_user.should == user
    end    
  end
  
  describe "#current_user?" do
    it "true" do
      helper.stubs(:current_user).returns(user)
      helper.current_user?(user).should be_true
    end
    it "other user" do
      helper.stubs(:current_user).returns(users(:dave))
      helper.current_user?(user).should be_false
    end
    it "no user" do
      helper.stubs(:current_user).returns(nil)
      helper.current_user?(user).should be_false
    end
  end
  
  describe "#admin_user?" do
    it "user is admin" do
      user = users(:admin)
      assign(:current_user, user)
      helper.admin_user?.should == true
    end
    it "user is not admin" do
      user = users(:dave)
      assign(:current_user, user)
      helper.admin_user?.should == false
    end
    it "no user is signed in" do
      assign(:current_user, nil)
      helper.admin_user?.should == false
    end
  end

end
