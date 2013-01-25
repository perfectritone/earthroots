class HerbsController < ApplicationController
  def index
    @herbs = Herb.all
  end

  def show
    @herb = Herb.find(params[:id])
  end

  def new
    @herb = Herb.new
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
end
