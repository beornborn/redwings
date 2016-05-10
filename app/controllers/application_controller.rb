class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = "Access denied!"
    redirect_to root_url
  end

  private

  def forbid_if_guest
    if current_user.guest?
      flash[:info] = 'You are Guest! Just watch and enjoy! :)'
      redirect_to :back
    end
  end

  def not_authenticated
    redirect_to login_path, info: "Please login first"
  end
end
