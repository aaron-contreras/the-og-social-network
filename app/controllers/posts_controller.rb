class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author, :likes).recent
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = Post.new(post_params)

    if params[:post][:like_own_post] == '1'
      @post.likes.build(user: current_user)
    end

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
end
