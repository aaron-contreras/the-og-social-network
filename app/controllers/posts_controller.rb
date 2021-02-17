class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author, :likes, :comments).recent
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = Post.new(post_params)

    @post.auto_like if posted_with_auto_like?

    if @post.save
      flash[:notice] = 'Succesfully posted to feed.'
      redirect_to posts_path
    else
      flash[:alert] = 'Fix some things before posting.'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :content)
  end

  def posted_with_auto_like?
    params[:post][:like_own_post] == '1'
  end
end
