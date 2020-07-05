class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:edit, :new, :create, :update, :destroy, :post_up]
  before_action :set_target_post,    only: [:show, :edit, :update, :destroy, :post_up]

  def index
    latest = Post.where(publish_flg: true).order(updated_at: "DESC")           #記事更新順
    like_ranks=Post.create_like_ranks.select{ |post| post.publish_flg==true }  #記事いいね順
    @all_user_ranks= User.create_all_user_ranks                                #ユーザの総いいね順
    @tag_ranks= TagMap.create_tag_ranks

    #ページネーション（最大２０件）
    @posts_all_ranks = Kaminari.paginate_array(like_ranks).page(params[:page]).per(20)
    @posts_latest = latest.page(params[:page]).per(20)
  end

  def search
    @posts = Post.search(params[:search]).page(params[:page]).per(20)
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
      redirect_to root_path and return
    end
    redirect_to edit_post_path @post
  end

  def show
    @user = @post.user
    @like = Like.new
    @stock = Stock.new
    @comments = @post.comments
    @comment = Comment.new
    
    #非公開の記事は本人以外参照できない
    if user_signed_in? == false && @post.publish_flg == false
        redirect_to root_path
    elsif @post.publish_flg == false && @post.user_id != current_user.id
        redirect_to root_path
    end
  end

  def edit
    @post.publish_flg=false
    @tag_list = @post.tags.pluck(:name).join(",")
    @post.save!
  end

  def update
    tag_list = tag_params[:tag_name].split(",",6)  #タグ名を,で区切り、配列にする
    tag_list.uniq!                                 #重複を削除
    
    #タグが5種類以上ならそれ以降のタグを削除する
    if tag_list.length >= 6
      tag_list.pop
    end
    
    if @post.update(post_params)
      @post.save_posts(tag_list)
    end
  end

  def post_up
    @post.publish_flg = true
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to "/users/#{current_user.id}"
    end
  end

  def destroy
    @post.tags.clear
    @post.delete
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  def post_params
    params.require(:post).permit(:user_id, :title, :content, :thumbnail_image, :publish_flg)
  end
  
  def tag_params
    params.require(:post).permit(:tag_name)
  end

  def set_target_post
    @post = Post.find(params[:id])
  end
end
