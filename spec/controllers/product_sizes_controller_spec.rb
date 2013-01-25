require File.dirname(__FILE__) + '/../spec_helper'

describe ProductSizesController do
  fixtures :product_sizes, :products, :users
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => ProductSize.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    ProductSize.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    ProductSize.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(product_size_url(assigns[:product_size]))
  end

  it "edit action should render edit template" do
    get :edit, :id => ProductSize.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    ProductSize.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ProductSize.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    ProductSize.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ProductSize.first
    response.should redirect_to(product_size_url(assigns[:product_size]))
  end

  it "destroy action should destroy model and redirect to index action" do
    product_size = ProductSize.first
    delete :destroy, :id => product_size
    response.should redirect_to(product_sizes_url)
    ProductSize.exists?(product_size.id).should be_false
  end
end
