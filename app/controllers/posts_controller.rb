class PostsController < ApplicationController
  before_action :post, only: [:edit, :show]

  def new
    @post = Post.new

    render 'form'
  end

  def create
    @post = Post.new(post_params)
    save_post
  end

  def edit
    render 'form'
  end

  def update
    post.assign_attributes(post_params)
    save_post
  end

  def destroy
    post.comments.destroy_all
    post.destroy

    flash[:notice] = 'Post deleted successfully!'
    redirect_to action: 'index'
  end

  private

  def save_post
    if post.save
      flash[:notice] = 'Post saved successfully!'
      redirect_to(post)
    else
      flash[:notice] = post.errors.full_messages.join(', ')
      render('form')
    end
  end

  def post
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
