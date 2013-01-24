require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsController do
  fixtures :users
  render_views
  let(:user) { FactoryGirl.create(:user) }
  
  describe "#new" do
    it "should render new log in page" do
      get :new
      response.should render_template 'new'
    end
  end
  
  describe "#create" do
    it "with credentials, should create a new session" do
      params = {  
        session: {
          email: user.email,
          password: user.password
        }
      }
      @controller.expects(:sign_in)
      post :create, params
      @controller.session[:return_to].should be_nil
      flash[:error].should be_nil
      response.should redirect_to user #response.should render_template 'show', controller: user
    end
    it "with invalid credentials, a valid email, but not password" do
      params = {  session: {
                    email: user.email,
                    password: "nope"
                  }
               }
      post :create, params       
      response.should render_template 'new'
      flash[:error].should_not be_nil 
    end
    it "with invalid credentials, invalid email" do
      params = {  session: {
                    email: "email",
                    password: "nope"
                  }
               }
      post :create, params       
      response.should render_template 'new'
      flash[:error].should_not be_nil 
    end
  end
  
  describe "#destroy" do
    it "should logout and redirect to home" do
      @controller.stubs(:sign_out)
      @controller.expects(:sign_out)
      delete :destroy
      response.should redirect_to root_path
    end
  end
end
