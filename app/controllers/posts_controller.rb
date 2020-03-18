class PostsController < ApplicationController
  
  before_action :authenticate_user!, only: [:edit, :new, :create, :update, :destroy]
  before_action :set_target_post, only: %i[show edit update destroy]
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def new
    @post=Post.new(
      user_id: current_user.id,
      title: "無題の記事",
      content: "ここに本文を入力してください",
    )
    unless @post.save
      flash[:alert] = "記事の作成に失敗しました"
      redirect_to articles_path and return
    end
  end
  
  def show
    @user = @post.user
  end
  
  def create
    @post=Post.new(
      user_id: current_user.id,
      title:params[:title],
      content:params[:content]
    )
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/")
    else
      render("posts/new")
    end
  end
  
  def edit
  end
  
  def update
    @post.update(post_params)
    redirect_to @post
  end
  
  def destroy
    @post.delete
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end
  
  def post_params
    params.require(:post).permit(:user_id,:title, :content)
  end
  
  def set_target_post
    @post = Post.find(params[:id])
  end
    
end
