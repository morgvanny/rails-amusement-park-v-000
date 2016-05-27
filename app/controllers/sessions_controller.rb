class SessionsController < ApplicationController

  def new
    @user = User.new
    @users = User.all
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  def create
    @user = User.find(params[:user][:id])
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end
end
