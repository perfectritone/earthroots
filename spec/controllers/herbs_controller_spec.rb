require File.dirname(__FILE__) + '/../spec_helper'

describe HerbsController do
  fixtures :herbs, :products, :users
  render_views
  
  let(:user) { users(:marco) }
  let(:admin) { users(:admin) }
  let(:herb) { herbs(:one) }

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Herb.first
    response.should render_template(:show)
  end

  describe "#new" do
    it "non-user, new action should redirect to index" do
      controller.stubs(:admin_user?).returns(false)
      get :new
      response.should redirect_to herbs_path
    end
    it "non-admin user, new action should redirect to index" do
      controller.stubs(:current_user).returns(user)
      user.stubs(:admin_user?).returns(false)
      get :new
      response.should redirect_to herbs_path
    end
    it "admin user, new action should render new template" do
      controller.stubs(:current_user).returns(admin)
      admin.stubs(:admin_user?).returns(true)
      get :new
      response.should render_template(:new)
    end
  end

  describe "#create" do
    it "non-user, new action should redirect to index" do
      controller.stubs(:admin_user?).returns(false)
      post :create
      response.should redirect_to herbs_path
    end
    it "non-admin user, new action should redirect to index" do
      controller.stubs(:current_user).returns(user)
      post :create
      response.should redirect_to herbs_path
    end
    it "admin user, create action should render new template when model is \
          invalid" do
      controller.stubs(:current_user).returns(admin)
      Herb.any_instance.stubs(:valid?).returns(false)
      post :create
      
      assigns[:herb].should be_new_record
      flash[:notice].should be_nil
      response.should render_template(:new)
    end

    it "admin user, create action should redirect when model is valid" do
      controller.stubs(:current_user).returns(admin)
      Herb.any_instance.stubs(:valid?).returns(true)
      post :create
      
      assigns[:herb].should_not be_new_record
      flash[:notice].should_not be_nil
      response.should redirect_to(herb_url(assigns[:herb]))
    end
  
    it "should pass params to herb on create" do
      controller.stubs(:admin_user).returns(true)
      params = {  
        herb: {
          name: herb.name
        }
      }
      post 'create', params
      assigns[:herb].name.should == herb.name
    end
  end

  describe "#edit" do
    it "non-user, redirect to herbs path" do
      controller.stubs(:current_user).returns(nil)
      get :edit, :id => Herb.first
      response.should redirect_to herbs_path
    end
    it "non-admin user, redirect to herbs pathe" do
      controller.stubs(:current_user).returns(user)
      get :edit, :id => Herb.first
      response.should redirect_to herbs_path
    end
    it "admin user, edit action should render edit template" do
      controller.stubs(:current_user).returns(admin)
      get :edit, :id => Herb.first
      response.should render_template(:edit)
    end
  end

  describe "#update" do
    it "non-user, redirect to herbs path" do
      controller.stubs(:current_user).returns(nil)
      put :update, :id => Herb.first
      response.should redirect_to herbs_path
    end
    it "non-admin user, redirect to herbs path" do
      controller.stubs(:current_user).returns(user)
      put :update, :id => Herb.first
      response.should redirect_to herbs_path
    end
    it "admin user, update action should render edit template when model is \
      invalid" do
      controller.stubs(:current_user).returns(admin)
      admin.stubs(:admin_user?).returns(true)
      Herb.any_instance.stubs(:valid?).returns(false)
      put :update, :id => Herb.first
      response.should render_template(:edit)
    end

    it "admin user, update action should redirect when model is valid" do
      controller.stubs(:current_user).returns(admin)
      admin.stubs(:admin_user?).returns(true)
      Herb.any_instance.stubs(:valid?).returns(true)
      put :update, :id => Herb.first
      response.should redirect_to(herb_url(assigns[:herb]))
    end
  end

  it "destroy action should destroy model and redirect to index action" do
    herb = Herb.first
    delete :destroy, :id => herb
    response.should redirect_to(herbs_url)
    Herb.exists?(herb.id).should be_false
  end
end
