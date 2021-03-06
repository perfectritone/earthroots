class ProductsController < ApplicationController
  include SessionsHelper
  before_filter :admin_user, only: [:new, :create, :edit, :update]
  
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @product.product_sizes.build
    @product.herbs.build
    @categories = Product.select(:category).uniq
  end

  def create  
    @product = Product.new(params[:product]) 
    @product.herbs.map! do |herb|
      # returns true if herb is already persisted
      # todo: benchmark against setting @product.herbs << persisted_herb w/ delete
      if persisted_herb = Herb.find_by_name(herb[:name])
        persisted_herb
      else
        herb
      end
    end
    if @product.save
      redirect_to @product, :notice => "Successfully created product."
    else
      render :action => 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Product.select(:category).uniq
  end

  def update
    @product = Product.find(params[:id])
    @updated_attributes = existing_herbs(@product, params[:product])
    if @product.update_attributes(@updated_attributes)
      redirect_to @product, :notice  => "Successfully updated product."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url, :notice => "Successfully destroyed product."
  end
  
  private
  
    def admin_user
      redirect_to(products_path) unless (current_user && current_user.admin?)
    end
    
    # Takes in a Product and a the Product Hash from the params Hash.
    # Returns an updated Product Hash, suitable to be sent as an argument to
    # update_attributes(), with all previously persisted herbs removed. This
    # herbs are instead added directly to the Product, which avoids duplication
    # of herbs in the db.
    def existing_herbs(product, product_hash)
      if product_hash.has_key?(:herbs_attributes)
        product_hash[:herbs_attributes].each do |i, herb|
          if (persisted_herb = Herb.find_by_name(herb[:name]))
            unless (herb.has_key?(:_destroy) && herb[:_destroy] == true)
              product.herbs << persisted_herb
            else
              product.herbs.delete(persisted_herb)
            end
            product_hash[:herbs_attributes].delete(i)
          end
        end
      end
      product_hash
    end
end
