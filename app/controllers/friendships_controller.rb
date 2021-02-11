class FriendshipsController < ApplicationController
  def index
    @users = User.friends_of(current_user)
    render 'users/index'    
  end

  def create
    friend = User.find(params[:friend_id])
    friendship_1 = current_user.friendships.build(friend: friend) 
    friendship_2 = friend.friendships.build(friend: current_user)

    if friendship_1.save && friendship_2.save
      friend_request = FriendRequest.find(params[:friend_request_id])
      friend_request.destroy

      flash[:notice] = "You've succesfully added someone to your friend list."
    else
      flash[:alert] = "Couldn't add to your friend list."
    end

    redirect_back(fallback_location: root_path)
  end
end
