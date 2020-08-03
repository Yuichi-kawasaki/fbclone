module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id]=user.id
    cookies.permanent[:remember_token]=user.remember_token
  end

  def logged_in?
    current_user.present?
  end
end
