module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token].to_s)
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def admin_user(redirect_path)
    redirect_to(redirect_path) unless (current_user && current_user.admin?)
  end
  
=begin  
  def admin_user?
    current_user.admin?
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to login_path, notice: "Please sign in."
    end
  end
  
  def store_location
    session[:return_to] = request.url # compare with request.referer
  end
=end
end
