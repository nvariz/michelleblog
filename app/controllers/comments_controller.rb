class CommentsController < ApplicationController
  def create
    @comment = post.comments.create!(params.require(:comment).permit(:name, :body))

    redirect_to post
  end

  def edit
    # TODO
  end

  def destroy
    comment.destroy

    redirect_to post
  end

  private

  def post
    @post ||= Post.find(params[:post_id])
  end

  def comment
    @comment ||= Comment.find(params[:id])
  end
end
