class HerbsController < ApplicationController
  include SessionsHelper
  before_filter :admin_user, only: [:new, :create, :edit, :update]
  
  def index
    @herbs = Herb.all
  end

  def show
    @herb = Herb.find(params[:id])
  end

  def new
    @herb = Herb.new
    @herb.common_names.build
    @herb.actions.build
    @herb.indications.build
  end

  def create
    @herb = Herb.new(params[:herb])
    if @herb.save
      redirect_to @herb, :notice => "Successfully created herb."
    else
      render :action => 'new'
    end
  end

  def edit
    @herb = Herb.find(params[:id])
  end

  def update
    @herb = Herb.find(params[:id])
    if @herb.update_attributes(params[:herb])
      redirect_to @herb, :notice  => "Successfully updated herb."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @herb = Herb.find(params[:id])
    @herb.destroy
    redirect_to herbs_url, :notice => "Successfully destroyed herb."
  end  
  
  private
  
    def admin_user
      redirect_to(herbs_path) unless (current_user && current_user.admin?)
    end
end
