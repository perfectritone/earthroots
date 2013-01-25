require File.dirname(__FILE__) + '/../spec_helper'

describe BlogsController do
  fixtures :blogs, :users
  render_views
  let(:user) { users(:marco) }
  let(:admin) { users(:admin) }
  let(:blog) { blogs(:one) }

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Blog.first
    response.should render_template(:show)
  end

  describe "#new" do
    it "non-user, new action should redirect to index" do
      controller.stubs(:admin_user?).returns(false)
      get :new
      response.should redirect_to blogs_path
    end
    it "non-admin user, new action should redirect to index" do
      controller.stubs(:current_user).returns(user)
      user.stubs(:admin_user?).returns(false)
      get :new
      response.should redirect_to blogs_path
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
      response.should redirect_to blogs_path
    end
    it "non-admin user, new action should redirect to index" do
      controller.stubs(:current_user).returns(user)
      post :create
      response.should redirect_to blogs_path
    end
    it "admin user, create action should render new template when model is \
          invalid" do
      controller.stubs(:current_user).returns(admin)
      Blog.any_instance.stubs(:valid?).returns(false)
      post :create
      
      assigns[:blog].should be_new_record
      flash[:notice].should be_nil
      response.should render_template(:new)
    end

    it "admin user, create action should redirect when model is valid" do
      controller.stubs(:current_user).returns(admin)
      Blog.any_instance.stubs(:valid?).returns(true)
      post :create
      
      assigns[:blog].should_not be_new_record
      flash[:notice].should_not be_nil
      response.should redirect_to(blog_url(assigns[:blog]))
    end
  
    it "should pass params to blog on create" do
      controller.stubs(:admin_user).returns(true)
      params = {  
        blog: {
          title: "Welcome!",
          content: "Nice to see you here."
        }
      }
      post 'create', params
      assigns[:blog].title.should == 'Welcome!'
    end
  end

  describe "#edit" do
    it "non-user, redirect to blogs path" do
      controller.stubs(:current_user).returns(nil)
      get :edit, :id => Blog.first
      response.should redirect_to blogs_path
    end
    it "non-admin user, redirect to blogs pathe" do
      controller.stubs(:current_user).returns(user)
      get :edit, :id => Blog.first
      response.should redirect_to blogs_path
    end
    it "admin user, edit action should render edit template" do
      controller.stubs(:current_user).returns(admin)
      get :edit, :id => Blog.first
      response.should render_template(:edit)
    end
  end

  describe "#update" do
    it "non-user, redirect to blogs path" do
      controller.stubs(:current_user).returns(nil)
      put :update, :id => Blog.first
      response.should redirect_to blogs_path
    end
    it "non-admin user, redirect to blogs path" do
      controller.stubs(:current_user).returns(user)
      put :update, :id => Blog.first
      response.should redirect_to blogs_path
    end
    it "admin user, update action should render edit template when model is \
      invalid" do
      controller.stubs(:current_user).returns(admin)
      admin.stubs(:admin_user?).returns(true)
      Blog.any_instance.stubs(:valid?).returns(false)
      put :update, :id => Blog.first
      response.should render_template(:edit)
    end

    it "admin user, update action should redirect when model is valid" do
      controller.stubs(:current_user).returns(admin)
      admin.stubs(:admin_user?).returns(true)
      Blog.any_instance.stubs(:valid?).returns(true)
      put :update, :id => Blog.first
      response.should redirect_to(blog_url(assigns[:blog]))
    end
  end

  it "destroy action should destroy model and redirect to index action" do
    blog = Blog.first
    delete :destroy, :id => blog
    response.should redirect_to(blogs_url)
    Blog.exists?(blog.id).should be_false
  end
end
