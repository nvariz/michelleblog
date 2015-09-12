class PostsController < ApplicationController
  before_action :post, only: [:edit, :show]

  def new
    @post = Post.new

    render 'form'
  end

  def create
    @post = Post.new(post_params)

    @post.save ? redirect_to(@post) : render('new')
  end

  def edit
    render 'form'
  end

  def update
    post.update!(post_params)

    redirect_to post
  end

  def destroy
    post.comments.destroy_all
    post.destroy

    redirect_to action: 'index'
  end

  private

  def post
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
