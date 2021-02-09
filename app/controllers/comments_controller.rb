class CommentsController < ApplicationController
  def new
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.build(comment_params)

    if post.save
      flash[:notice] = 'Your comment has been added to the post.'
    else
      flash[:alert] = 'Fix up a couple things before commenting.'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
