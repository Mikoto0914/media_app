class PostsController < ApplicationController
  
  before_action :authenticate_user!, only: [:edit, :new, :create, :update, :destroy]
  before_action :set_target_post, only: %i[show edit update destroy preview]
  
  def index
    @posts = Post.where(publish_flg: true)
  end
  
  def new
    @post=Post.new(
      user_id: current_user.id,
      title: "無題の記事",
      content: "ここに本文を入力してください",
      publish_flg: false
    )
    unless @post.save
      flash[:alert] = "記事の作成に失敗しました"
      redirect_to articles_path and return
    end
    redirect_to edit_post_path @post
  end
  
  def show
    @user = @post.user
  end
  
  def edit
  end
  
  def preview
    @user = @post.user
  end
  
  def update
    @post.update(post_params)
    flash[:alert] = "記事を作成しました。"
    redirect_to "/"
  end
  
  def destroy
    @post.delete
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end
  
  def post_params
    params.require(:post).permit(:user_id, :title, :content, :publish_flg)
  end
  
  def set_target_post
    @post = Post.find(params[:id])
  end
    
end
