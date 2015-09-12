class PostsController < ApplicationController
  def create
    @post = Post.new(params.require(:post).permit(:title, :body))

    @post.save ? redirect_to(@post) : render('new')
  end

  def show
    @post = Post.find(params[:id])
  end
end
