class BlogsController < ApplicationController
  include SessionsHelper
  before_filter :admin_user, only: [:new, :create, :edit, :update]
  
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(params[:blog])
    if @blog.save
      redirect_to @blog, :notice => "Successfully created blog."
    else
      render :action => 'new'
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(params[:blog])
      redirect_to @blog, :notice  => "Successfully updated blog."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_url, :notice => "Successfully destroyed blog."
  end
  
  private
  
    def admin_user
      redirect_to(blogs_path) unless (current_user && current_user.admin?)
    end
end
