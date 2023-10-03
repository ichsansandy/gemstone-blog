class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @post = Post.find(params[:id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    return unless @comment.save

    redirect_to user_post_path(params[:user_id], params[:id]), notice: 'Comment was successfully added.'
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    @post.decrement!(:comment_counter)
    @comment.destroy
    redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
