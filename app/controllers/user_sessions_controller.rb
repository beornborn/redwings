class UserSessionsController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to( greeting_path , success: 'Login successful')
    else
      flash.now[:danger] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to( root_path, success: 'Logged out!')
  end

end

