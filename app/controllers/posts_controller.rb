class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author)
  end
end
