class UsersController < ApplicationController
  load_and_authorize_resource

  before_filter :find_user, only: [:edit, :update]

  attr_accessor :skip_password_validation

  def show
  end

  def index
    @current_filter = params[:filter] || 'Academy'

    @projects = Project.all

    @users = if @current_filter == 'Disabled'
      User.disabled
    else
      User.by_project(@current_filter).active
    end

    @users = @users.order(started_at: :desc).page(params[:page])
  end

  def update
    @user.attributes = user_params

    if @user.save!
      flash[:success] = "Goodbye letter has been successfully sent to #{@user.email}."
      UserMailer.goodbye_reason(@user).deliver_later
    end

    redirect_to users_path
  end

  def edit
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:goodbye_reason, :goodbye_letter)
  end
end
