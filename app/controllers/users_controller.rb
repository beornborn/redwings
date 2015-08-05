class UsersController < ApplicationController

  before_filter :find_user, only: [:edit, :update]

  attr_accessor :skip_password_validation

  def index
    @projects = Project.all

    if params[:filter].present?
      @users = (params[:filter] == 'disabled') ? User.disabled : User.by_project(params[:filter].capitalize, current_user)
    else
      @users = User.by_project('Academy', current_user)
    end
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

