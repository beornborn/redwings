class UsersController < ApplicationController
  load_and_authorize_resource

  before_filter :find_user, only: [:edit, :update, :quit_project, :enter_project, :edit_goodbye_reason, :update_goodbye_reason]
  before_filter :find_project, only: [:quit_project, :enter_project]

  def show
  end

  def index
    @current_filter = params[:filter] || 'Academy'

    @projects = Project.all

    @users = if @current_filter == 'Disabled'
      User.disabled.order('goodbye_reason ASC NULLS FIRST')
    else
      User.by_project(@current_filter).active
    end

    @users = @users.order(started_at: :desc).page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your changes have been saved!'
      redirect_to @user
    else
      render :show
    end
  end

  def edit_goodbye_reason
  end

  def update_goodbye_reason
    if @user.update!(goodbye_reason_params)
      flash[:success] = "Goodbye letter has been successfully sent to #{@user.email}."
    end

    redirect_to users_path
  end

  def quit_project
    @user.projects.delete(@project)
    redirect_to :back
  end

  def enter_project
    @user.projects << @project
    redirect_to :back
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def goodbye_reason_params
    params.require(:user).permit(:goodbye_reason, :goodbye_letter)
  end

  def user_params
    params.require(:user).permit(:about)
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end
