class BooksController < ApplicationController
  include SessionsHelper
  before_filter :admin_user, only: [:new, :create, :edit, :update]
  
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      redirect_to @book, :notice => "Successfully created book."
    else
      render :action => 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:book])
      redirect_to @book, :notice  => "Successfully updated book."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_url, :notice => "Successfully destroyed book."
  end
  
  private
  
    def admin_user
      redirect_to(books_path) unless (current_user && current_user.admin?)
    end
end
