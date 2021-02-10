class FriendRequestsController < ApplicationController
  def create
    friend_request = current_user.sent_requests.build(recipient_id: params[:recipient_id])
    if friend_request.save
      flash[:notice] = 'Friend request sent.'
    else
      flash[:alert] = 'Something went wrong with sending your friend request.'
    end

    redirect_back(fallback_location: root_path) 
  end

  def destroy
    friend_request = FriendRequest.find(params[:friend_request_id])
    if friend_request.destroy
      flash[:notice] = 'Friend request cancelled.'
    else
      flash[:alert] = 'Something went wrong with cancelling your friend request.'
    end
    redirect_back(fallback_location: root_path)
  end
end
