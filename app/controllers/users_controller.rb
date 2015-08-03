class UsersController < ApplicationController

  before_filter :find_user, only: [:edit, :update]

  attr_accessor :skip_password_validation

  def index
<<<<<<< HEAD
    @users = User.where.not(id: current_user.id).admin(false).deleted(false).order(started_at: :desc).page(params[:page])
    @users_deleted = User.admin(false).deleted(true).order(started_at: :desc)
=======
    @users = User.where.not(id: current_user.id).admin(false).deleted(false).order(started_at: :desc).decorate
    @users_deleted = User.admin(false).deleted(true).order(started_at: :desc).decorate
>>>>>>> develop
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

