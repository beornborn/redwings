class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :require_login

  def current_user
    user = super
    user.present? ? UserDecorator.decorate(user) : user
  end

  private

  def not_authenticated
    redirect_to login_path, info: "Please login first"
  end
end
