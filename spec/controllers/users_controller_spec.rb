require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fixtures :users
  render_views

  describe "#index" do
    it "should redirect to root when not admin" do
      controller.stubs(:current_user).returns(users(:dave))
      get :index
      
      response.should redirect_to root_path
    end
    
    it "index action should render index template" do
      controller.stubs(:current_user).returns(users(:admin))
      get :index
      
      response.should render_template(:index)
    end
  end

  describe "#show" do
    it "show action should render show template" do
      get :show, :id => User.first
      response.should render_template(:show)
    end
  end

  describe "#new" do
    it "new action should render new template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "#create" do
    it "create action should render new template when model is invalid" do
      User.any_instance.stubs(:valid?).returns(false)
      post :create
      
      assigns[:user].should be_new_record
      flash[:notice].should be_nil
      response.should render_template(:new)
    end

    it "create action should redirect when model is valid" do
      User.any_instance.stubs(:valid?).returns(true)
      post :create
      
      flash[:notice].should_not be_nil
      response.should redirect_to(user_url(assigns[:user]))
    end
  end

  describe "#edit" do
    it "when the current user is not the user to be edited" do
      controller.stubs(:current_user?).returns(false)
      get :edit, :id => User.first
      
      response.should redirect_to root_path
    end
    
    it "edit action should render edit template" do
      controller.stubs(:current_user?).returns(true)
      get :edit, :id => User.first
      
      response.should render_template(:edit)
    end
  end

  describe "#update" do
    it "when current user is not the user to be updated" do
      user = User.find(1)
      controller.stubs(:current_user?).returns(false)
      put :update, :id => User.find(2)
      
      response.should redirect_to root_path
    end
    
    it "update action should render edit template when model is invalid" do
      User.any_instance.stubs(:valid?).returns(false)
      controller.stubs(:current_user?).returns(true)
      put :update, :id => User.first
      
      flash[:notice].should be_nil
      response.should render_template(:edit)
    end

    it "update action should redirect when model is valid" do
      User.any_instance.stubs(:valid?).returns(true)
      controller.stubs(:current_user?).returns(true)
      put :update, :id => User.first
      
      flash[:notice].should_not be_nil
      response.should redirect_to(user_url(assigns[:user]))
    end
  end

  describe "#delete" do
    it "when user is not admin" do
      user = User.find_by_name("Titea")
      controller.stubs(:current_user).returns(users(:dave))
      delete :destroy, :id => user
      
      response.should redirect_to(root_path)
    end
    
    describe "when user is admin" do
      it "destroy action should destroy model and redirect to index action" do
        user = User.first
        controller.stubs(:current_user).returns(users(:admin))
        delete :destroy, :id => user
        
        flash[:notice].should_not be_nil
        flash[:error].should be_nil
        response.should redirect_to(users_url)
        User.exists?(user.id).should be_false
      end
      
      it "destroy action should not find user and not redirect" do
        user = User.first
        controller.stubs(:current_user).returns(users(:admin))
        delete :destroy, :id => -1
        
        flash[:notice].should be_nil
        flash[:error].should_not be_nil
        response.should redirect_to(users_url)
      end
    end
  end

end
