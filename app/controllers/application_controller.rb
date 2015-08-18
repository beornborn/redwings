class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  rescue_from CanCan::AccessDenied do
    flash[:danger] = 'Access denied!'
    redirect_to root_url
  end

  private

  def not_authenticated
    redirect_to login_path, info: 'Please login first'
  end
end
