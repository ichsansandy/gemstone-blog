class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post # Ensure user is authorized to delete the post
    @author = @post.author
    @author.decrement!(:post_counter)
    @post.destroy!
    redirect_to user_posts_path(params[:user_id]), notice: "Post was successfully deleted."
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_posts_path(current_user)

    else
      flash[:alert] = 'Something went wrong'
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
