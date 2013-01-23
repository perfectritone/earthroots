require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsHelper do
  fixtures :users

  it "current user should be saved" do
    helper.current_user = users(:dave)
    helper.current_user.should == users(:dave)
  end
=begin
  it "sign in user" do
    helper.stubs()
  end
  
  it "current user should look in cookies for :remember_token" do
    helper.cookies.stubs(:)
    User.any_instance.stubs(:find_by_remember_tokens)
    helper.current_user.should == helper.send(:"@current_user")
  end
=end
end
