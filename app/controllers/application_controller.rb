class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :require_login

  def current_user
   UserDecorator.decorate(super) unless super == false
  end

  private

  def not_authenticated
    redirect_to login_path, info: "Please login first"
  end

end

