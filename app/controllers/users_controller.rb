class UsersController < ApplicationController
  def index
    @users = User.includes(:friends, :sent_requests).not_including(current_user)
  end

  def show
    @user = User.includes(:friends, :posts, :sent_requests).find(params[:id])    
  end
end
