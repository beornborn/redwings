class UsersController < ApplicationController
  load_and_authorize_resource

  before_filter :find_user, only: [:edit, :update]

  attr_accessor :skip_password_validation

  def index
    @projects = Project.all.decorate

    @users = if params[:filter].blank?
      User.by_project('Academy').active.without(current_user)
    elsif params[:filter] == 'Disabled'
      User.disabled
    else
      User.by_project(params[:filter]).active.without(current_user)
    end

    params[:show_current_user] = current_user.projects.find { |project| project.name == params[:filter] } if params[:filter].present?

    @users = @users.decorate
    @user  = @users.first
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

