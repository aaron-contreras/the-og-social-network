class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    like = post.likes.build(user_id: current_user.id)
    like.save
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy

    redirect_back(fallback_location: root_path)
  end
end
