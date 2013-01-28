require File.dirname(__FILE__) + '/../spec_helper'

describe LinksController do
  fixtures :links, :users
  render_views
  
  let(:user) { users(:marco) }
  let(:admin) { users(:admin) }
  let(:link) { links(:one) }

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Link.first
    response.should render_template(:show)
  end

  describe "#new" do
    it "non-user, new action should redirect to index" do
      controller.stubs(:admin_user?).returns(false)
      get :new
      response.should redirect_to links_path
    end
    it "non-admin user, new action should redirect to index" do
      controller.stubs(:current_user).returns(user)
      user.stubs(:admin_user?).returns(false)
      get :new
      response.should redirect_to links_path
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
      response.should redirect_to links_path
    end
    it "non-admin user, new action should redirect to index" do
      controller.stubs(:current_user).returns(user)
      post :create
      response.should redirect_to links_path
    end
    it "admin user, create action should render new template when model is \
          invalid" do
      controller.stubs(:current_user).returns(admin)
      Link.any_instance.stubs(:valid?).returns(false)
      post :create
      
      assigns[:link].should be_new_record
      flash[:notice].should be_nil
      response.should render_template(:new)
    end

    it "admin user, create action should redirect when model is valid" do
      controller.stubs(:current_user).returns(admin)
      Link.any_instance.stubs(:valid?).returns(true)
      post :create
      
      assigns[:link].should_not be_new_record
      flash[:notice].should_not be_nil
      response.should redirect_to(link_url(assigns[:link]))
    end
  
    it "should pass params to link on create" do
      controller.stubs(:admin_user).returns(true)
      params = {  
        link: {
          name: link.name,
          address: link.address,
          category: link.category
        }
      }
      post 'create', params
      assigns[:link].name.should == link.name
    end
  end

  describe "#edit" do
    it "non-user, redirect to links path" do
      controller.stubs(:current_user).returns(nil)
      get :edit, :id => Link.first
      response.should redirect_to links_path
    end
    it "non-admin user, redirect to links pathe" do
      controller.stubs(:current_user).returns(user)
      get :edit, :id => Link.first
      response.should redirect_to links_path
    end
    it "admin user, edit action should render edit template" do
      controller.stubs(:current_user).returns(admin)
      get :edit, :id => Link.first
      response.should render_template(:edit)
    end
  end

  describe "#update" do
    it "non-user, redirect to links path" do
      controller.stubs(:current_user).returns(nil)
      put :update, :id => Link.first
      response.should redirect_to links_path
    end
    it "non-admin user, redirect to links path" do
      controller.stubs(:current_user).returns(user)
      put :update, :id => Link.first
      response.should redirect_to links_path
    end
    it "admin user, update action should render edit template when model is \
      invalid" do
      controller.stubs(:current_user).returns(admin)
      admin.stubs(:admin_user?).returns(true)
      Link.any_instance.stubs(:valid?).returns(false)
      put :update, :id => Link.first
      response.should render_template(:edit)
    end

    it "admin user, update action should redirect when model is valid" do
      controller.stubs(:current_user).returns(admin)
      admin.stubs(:admin_user?).returns(true)
      Link.any_instance.stubs(:valid?).returns(true)
      put :update, :id => Link.first
      response.should redirect_to(link_url(assigns[:link]))
    end
  end

  it "destroy action should destroy model and redirect to index action" do
    link = Link.first
    delete :destroy, :id => link
    response.should redirect_to(links_url)
    Link.exists?(link.id).should be_false
  end
end
