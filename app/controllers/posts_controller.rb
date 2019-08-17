class PostsController < ApplicationController
  def index
    # 記事一覧を取得する際にユーザーも取得することでN+1問題を解決する
    @posts = Post.all.includes(:user)
  end

  def show
    @post = Post.find(params[:id])
  end
end
