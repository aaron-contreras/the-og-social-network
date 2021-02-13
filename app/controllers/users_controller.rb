class UsersController < ApplicationController
  def index
    @users = User.not_including(current_user)
  end

  def show
    
  end
end
