class CommentsController < ApplicationController
  def create
    @post    = Post.find(params[:post_id])
    @comment = @post.comments.create!(params.require(:comment).permit(:name, :body))

    redirect_to @post
  end
end
