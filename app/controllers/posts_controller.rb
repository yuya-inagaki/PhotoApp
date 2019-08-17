class PostsController < ApplicationController
  def index
    # 記事一覧を取得する際にユーザーも取得することでN+1問題を解決する
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    # render plain: params[:post].inspect
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "記事を作成しました"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "記事をアップデートしました"
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
