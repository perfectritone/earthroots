class ProductSizesController < ApplicationController
  def index
    @product_sizes = ProductSize.all
  end

  def show
    @product_size = ProductSize.find(params[:id])
  end

  def new
    @product_size = ProductSize.new
  end

  def create
    @product_size = ProductSize.new(params[:product_size])
    if @product_size.save
      redirect_to @product_size, :notice => "Successfully created product size."
    else
      render :action => 'new'
    end
  end

  def edit
    @product_size = ProductSize.find(params[:id])
  end

  def update
    @product_size = ProductSize.find(params[:id])
    if @product_size.update_attributes(params[:product_size])
      redirect_to @product_size, :notice  => "Successfully updated product size."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @product_size = ProductSize.find(params[:id])
    @product_size.destroy
    redirect_to product_sizes_url, :notice => "Successfully destroyed product size."
  end
end
