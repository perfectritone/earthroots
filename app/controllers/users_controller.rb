class UsersController < ApplicationController
  include SessionsHelper
  #before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update] # destroy
  before_filter :admin_user, only: [:index, :destroy]

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(params[:user])
    if (@user.save)
      sign_in @user
      flash[:notice] = "Welcome to Earth Roots! Thanks for joining"
      redirect_to user_path @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def destroy
    @user = User.find(params[:id]).destroy
    unless User.find_by_id(params[:id])
      flash[:notice] = "User removed"
      redirect_to users_path
    else
      flash[:error] = "User could not be removed"
      redirect_to user_path @user
    end
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "User could not be found"
    redirect_to users_path
  end

  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless (current_user && current_user.admin?)
    end
end
