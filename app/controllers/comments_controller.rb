class CommentsController < ApplicationController
  before_action :post, only: :edit

  def create
    @comment = post.comments.new(comment_params)
    if @comment.save
      flash[:notice] = 'Comment saved successfully'
      redirect_to post
    else
      flash[:notice] = comment.errors.full_messages.join(',')
      redirect_to post
    end
  end

  def edit
    render partial: 'shared/comments_form', locals: { comment: comment }
  end

  def update
    comment.assign_attributes(comment_params)
    if @comment.save
      flash[:notice] = 'Comment saved successfully'
      redirect_to post
    else
      flash[:notice] = comment.errors.full_messages.join(',')
      redirect_to post
    end
  end

  def destroy
    comment.destroy

    redirect_to post
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :body)
  end

  def post
    @post ||= Post.find(params[:post_id])
  end

  def comment
    @comment ||= Comment.find(params[:id])
  end
end
