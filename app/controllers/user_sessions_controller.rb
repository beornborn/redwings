class UserSessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create, :guest_enter]

  def new
  end

  def guest_enter
    user = User.find_or_create_by(guest: true) do |u|
      u.username = 'Guest'
      u.first_name = 'Guest'
      u.last_name = 'Guest'
      u.email = 'guest@guest.com'
    end
    @user = auto_login(user)
    redirect_back_or_to root_path, success: 'Guest session. You can see but you can\'t change anything'
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember])
      redirect_back_or_to root_path , success: 'Login successful.'
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
