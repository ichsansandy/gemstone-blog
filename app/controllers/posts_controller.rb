class PostsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :post, through: :user

  before_action :set_user, only: %i[index show]
  before_action :set_post, only: %i[show destroy]

  def index
    @posts = @user.posts
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def destroy
    @author = @post.author
    @author.decrement!(:post_counter)
    @post.destroy!
    redirect_to user_posts_path(params[:user_id]), notice: 'Post was successfully deleted.'
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

  def set_post
    @post = Post.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
