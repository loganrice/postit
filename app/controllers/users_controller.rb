class UsersController < ApplicationController
  before_action :set_up_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    binding.pry

    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Your post was created."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    set_up_user
  end

  def edit
    set_up_user
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile was updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  def set_up_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

end