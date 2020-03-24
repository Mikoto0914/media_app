class UsersController < ApplicationController
  
  before_action :authenticate_user!, only: [:drafts, :favorite, :profile_edit]
  
  def show
    @user = User.find_by(id: params[:id])
    @posts_latest = Post.where(user: params[:id]).where(publish_flg: true).order(id: "DESC")
    @posts_my_ranks = Post.create_all_ranks.select{ |post| post.user_id == @user.id && post.publish_flg==true }
    @posts_likes = @user.liked_posts
  end
  
  def drafts
    @posts_drafts = Post.where(user: current_user.id).where(publish_flg: false).order(id: "DESC")
    @posts_releas = Post.where(user: current_user.id).where(publish_flg: true).order(id: "DESC")
  end

  def favorite
    @posts_favorite = current_user.stocked_posts
  end
  
  def profile_edit
  end
  
end
