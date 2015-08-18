class UserSessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember])
      redirect_back_or_to root_path, success: 'Login successful.'
    else
      flash.now[:danger] = 'Login failed.'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, success: 'Logged out!'
  end
end
