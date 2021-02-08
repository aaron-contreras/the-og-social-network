class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author, :likes)
  end
end
