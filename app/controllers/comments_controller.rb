class CommentsController < ApplicationController
  def create
    @comment = post.comments.new(comment_params)
    if @comment.save
      flash[:notice] = 'Comment saved successfully'
      redirect_to post
    else
      flash[:notice] = comment.errors.full_messages.join(',')
      render 'posts/show'
    end
  end

  def edit
    # TODO
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
