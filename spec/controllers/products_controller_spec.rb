require File.dirname(__FILE__) + '/../spec_helper'

describe ProductsController do
  fixtures :products, :users
  render_views
  
  let(:user) { users(:marco) }
  let(:admin) { users(:admin) }
  let(:product) { products(:one) }

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Product.first
    response.should render_template(:show)
  end

  describe "#new" do
    it "non-user, new action should redirect to index" do
      controller.stubs(:admin_user?).returns(false)
      get :new
      response.should redirect_to products_path
    end
    it "non-admin user, new action should redirect to index" do
      controller.stubs(:current_user).returns(user)
      user.stubs(:admin_user?).returns(false)
      get :new
      response.should redirect_to products_path
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
      response.should redirect_to products_path
    end
    it "non-admin user, new action should redirect to index" do
      controller.stubs(:current_user).returns(user)
      post :create
      response.should redirect_to products_path
    end
    
    describe "admin user" do
      before do
        controller.stubs(:current_user).returns(admin)
        @new_product = FactoryGirl.build(:product)
      end
      
      it "admin user, create action should render new template when model is \
            invalid" do
        Product.any_instance.stubs(:valid?).returns(false)
        post :create
        
        assigns[:product].should be_new_record
        flash[:notice].should be_nil
        response.should render_template(:new)
      end

      it "admin user, create action should redirect when model is valid" do
        Product.any_instance.stubs(:valid?).returns(true)
        post :create
        
        assigns[:product].should_not be_new_record
        flash[:notice].should_not be_nil
        response.should redirect_to(product_url(assigns[:product]))
      end
    
      it "should pass params to product on create" do
        new_name = product.name + " #2"
        params = {  
          product: {
            name: new_name,
            category: product.category,
            description: product.description
          }
        }
        post 'create', params
        assigns[:product].name.should == new_name
      end
      
      it "should increase Herb count by 1 on save" do
        params = {  
          product: {
            name: @new_product.name,
            category: @new_product.category,
            description: @new_product.description,
            herbs_attributes: [name: "New Herb"]
          }
        }
        old_herb_count = Herb.count
        post 'create', params
        Product.find_by_name(@new_product.name).herbs.count.should == 1
        Herb.count.should == old_herb_count + 1
      end
      
      it "should increase associated Herb count by 1 on save, but not change\
        the Herb count" do
        @persisted_herb = Herb.create( name: "Persistent Herb" )
        params = {  
          product: {
            name: @new_product.name,
            category: @new_product.category,
            description: @new_product.description,
            herbs_attributes: [name: @persisted_herb.name]
          }
        }
        old_herb_count = Herb.count
        post 'create', params
        Product.find_by_name(@new_product.name).herbs.count.should == 1
        Herb.count.should == old_herb_count
      end
      
      it "should remove association when passed _destroy: true,\
        but leave the herb untouched" do
        @persisted_herb = Herb.create( name: "Persistent Herb" )
        params = {  
          product: {
            name: @new_product.name,
            category: @new_product.category,
            description: @new_product.description,
            herbs_attributes: [name: @persisted_herb.name, _destroy: true]
          }
        }
        old_herb_count = Herb.count
        post 'create', params
        Product.find_by_name(@new_product.name).herbs.count.should == 0
        Herb.count.should == old_herb_count
      end
      
    end
  end

  describe "#edit" do
    it "non-user, redirect to products path" do
      controller.stubs(:current_user).returns(nil)
      get :edit, :id => Product.first
      response.should redirect_to products_path
    end
    it "non-admin user, redirect to products pathe" do
      controller.stubs(:current_user).returns(user)
      get :edit, :id => Product.first
      response.should redirect_to products_path
    end
    it "admin user, edit action should render edit template" do
      controller.stubs(:current_user).returns(admin)
      get :edit, :id => Product.first
      response.should render_template(:edit)
    end
  end

  describe "#update" do
    it "non-user, redirect to products path" do
      controller.stubs(:current_user).returns(nil)
      put :update, :id => Product.first
      response.should redirect_to products_path
    end
    it "non-admin user, redirect to products path" do
      controller.stubs(:current_user).returns(user)
      put :update, :id => Product.first
      response.should redirect_to products_path
    end
    
    describe "admin" do
      before do
        controller.stubs(:current_user).returns(admin)
        @new_product = FactoryGirl.create(:product)
      end
      
      it "update action should render edit template when model is \
        invalid" do
        controller.stubs(:current_user).returns(admin)
        admin.stubs(:admin_user?).returns(true)
        controller.stubs(:existing_herbs).returns(nil)
        Product.any_instance.stubs(:valid?).returns(false)
        put :update, :id => Product.first
        response.should render_template(:edit)
      end

      it "update action should redirect when model is valid" do
        controller.stubs(:current_user).returns(admin)
        admin.stubs(:admin_user?).returns(true)
        controller.stubs(:existing_herbs).returns(nil)
        Product.any_instance.stubs(:valid?).returns(true)
        put :update, :id => Product.first
        response.should redirect_to(product_url(assigns[:product]))
      end
      
      it "should increase Herb count by 1" do
        @old_herb_count = Herb.count
        @updated_product = HashWithIndifferentAccess.new ({
          herbs_attributes: HashWithIndifferentAccess.new({
            "0" => HashWithIndifferentAccess.new({
              name: "New Herb" # Added attribute
            })
          })
        })
        
        put :update, id: @new_product.id, product: @updated_product
        @new_product.herbs.count.should == 1
        Herb.count.should == @old_herb_count + 1
      end
      
      it "should increase associated Herb count by 1, not change persisted \
        Herb count" do
        @persisted_herb = Herb.create(name: "Persisted Herb")
        @old_herb_count = Herb.count
        @updated_product_attrs = HashWithIndifferentAccess.new ({
          herbs_attributes: HashWithIndifferentAccess.new({
            "0" => HashWithIndifferentAccess.new({
              name: @persisted_herb.name
            })
          })
        })
        
        put :update, id: @new_product.id, product: @updated_product_attrs
        @new_product.herbs.count.should == 1
        Herb.count.should == @old_herb_count
      end
      
      it "should remove association when passed _destroy: true,\
        but leave the herb untouched" do
        @persisted_herb = @new_product.herbs.create(name: "Persisted Herb")
        @old_herb_count = Herb.count
        @updated_product_attrs = HashWithIndifferentAccess.new ({
          herbs_attributes: HashWithIndifferentAccess.new({
            "0" => HashWithIndifferentAccess.new({
              name: @persisted_herb.name,
              _destroy: true
            })
          })
        })
        
        put :update, id: @new_product.id, product: @updated_product_attrs
        @new_product.herbs.count.should == 0
        Herb.count.should == @old_herb_count
      end
    end
  end

  it "destroy action should destroy model and redirect to index action" do
    product = Product.first
    delete :destroy, :id => product
    response.should redirect_to(products_url)
    Product.exists?(product.id).should be_false
  end
end
